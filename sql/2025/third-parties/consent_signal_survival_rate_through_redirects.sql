#standardSQL
# Consent signal survival rate through HTTP redirects

CREATE TEMP FUNCTION extractConsentSignals(url STRING)
RETURNS STRUCT<
  has_usp_standard BOOL,
  has_usp_nonstandard BOOL,
  has_tcf_standard BOOL,
  has_gpp_standard BOOL,
  has_any_signal BOOL,
  signal_count INT64
>
LANGUAGE js AS """
  try {
    const signals = {
      has_usp_standard: /[?&]us_privacy=/.test(url),
      has_usp_nonstandard: /[?&](ccpa|usp_consent|uspString|sst\\.us_privacy|uspConsent|ccpa_consent|AV_CCPA|usp|usprivacy|_fw_us_privacy|D9v\\.us_privacy|cnsnt|ccpaconsent|usp_string)=/.test(url),
      has_tcf_standard: /[?&](gdpr|gdpr_consent|gdpr_pd)=/.test(url),
      has_gpp_standard: /[?&](gpp|gpp_sid)=/.test(url)
    };

    signals.signal_count = [
      signals.has_usp_standard,
      signals.has_usp_nonstandard,
      signals.has_tcf_standard,
      signals.has_gpp_standard
    ].filter(Boolean).length;

    signals.has_any_signal = signals.signal_count > 0;

    return signals;
  } catch (e) {
    return {
      has_usp_standard: false,
      has_usp_nonstandard: false,
      has_tcf_standard: false,
      has_gpp_standard: false,
      has_any_signal: false,
      signal_count: 0
    };
  }
""";

WITH pages AS (
  SELECT
    client,
    page,
    rank
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
),

-- Get redirect chains from crawl.requests summary column
redirect_chains AS (
  SELECT
    r.client,
    r.page,
    r.url AS final_url,
    JSON_EXTRACT(r.summary, '$.redirects') AS redirects,
    JSON_EXTRACT_SCALAR(r.summary, '$.startedDateTime') AS startedDateTime,
    JSON_EXTRACT_SCALAR(r.summary, '$.endedDateTime') AS endedDateTime,
    NET.REG_DOMAIN(r.url) AS final_domain
  FROM
    `httparchive.crawl.requests` r
  INNER JOIN
    pages p
  ON
    r.client = p.client AND r.page = p.page
  WHERE
    r.date = '2025-07-01' AND
    JSON_EXTRACT(r.summary, '$.redirects') IS NOT NULL AND
    JSON_EXTRACT(r.summary, '$.redirects') != '[]' AND
    -- AND p.rank <= 100000  -- Limit to top 100K sites
    NET.REG_DOMAIN(r.page) != NET.REG_DOMAIN(r.url)  -- Third-party only
),

-- Parse redirect chains and extract consent signals at each step
parsed_redirects AS (
  SELECT
    client,
    page,
    final_url,
    final_domain,
    redirect_step.url AS step_url,
    redirect_step.redirectURL AS next_url,
    ROW_NUMBER() OVER (
      PARTITION BY client, page, final_url
      ORDER BY COALESCE(redirect_step.startedDateTime, redirect_chains.startedDateTime)
    ) AS redirect_step_number,
    extractConsentSignals(redirect_step.url) AS step_signals,
    extractConsentSignals(COALESCE(redirect_step.redirectURL, final_url)) AS next_signals
  FROM
    redirect_chains,
    UNNEST(JSON_EXTRACT_ARRAY(redirects)) AS redirect_step_json,
    UNNEST([STRUCT(
      JSON_EXTRACT_SCALAR(redirect_step_json, '$.url') AS url,
      JSON_EXTRACT_SCALAR(redirect_step_json, '$.redirectURL') AS redirectURL,
      JSON_EXTRACT_SCALAR(redirect_step_json, '$.startedDateTime') AS startedDateTime
    )]) AS redirect_step
  WHERE
    redirect_step.url IS NOT NULL
),

-- Add final URL as the last step
redirect_chains_with_final AS (
  -- Intermediate redirect steps
  SELECT
    client,
    page,
    final_url,
    final_domain,
    redirect_step_number,
    step_url AS url_at_step,
    step_signals AS signals_at_step,
    'redirect' AS step_type
  FROM
    parsed_redirects

  UNION ALL

  -- Final destination URL
  SELECT
    client,
    page,
    final_url,
    final_domain,
    MAX(redirect_step_number) + 1 AS redirect_step_number,
    final_url AS url_at_step,
    extractConsentSignals(final_url) AS signals_at_step,
    'final' AS step_type
  FROM
    parsed_redirects
  GROUP BY
    client,
    page,
    final_url,
    final_domain
),

-- Calculate signal preservation statistics by step
step_survival_stats AS (
  SELECT
    client,
    redirect_step_number,
    step_type,

    -- Signals present at this step
    COUNTIF(signals_at_step.has_usp_standard) AS usp_standard_at_step,
    COUNTIF(signals_at_step.has_usp_nonstandard) AS usp_nonstandard_at_step,
    COUNTIF(signals_at_step.has_tcf_standard) AS tcf_standard_at_step,
    COUNTIF(signals_at_step.has_gpp_standard) AS gpp_standard_at_step,
    COUNTIF(signals_at_step.has_any_signal) AS any_signal_at_step,

    -- Average signal count per URL
    AVG(signals_at_step.signal_count) AS avg_signal_count_at_step,

    COUNT(0) AS total_urls_at_step,
    COUNT(DISTINCT page) AS total_pages_at_step
  FROM
    redirect_chains_with_final
  WHERE
    redirect_step_number <= 6  -- Limit to first 6 steps (most redirects are short)
  GROUP BY
    client,
    redirect_step_number,
    step_type
),

-- Get baseline (first step) for survival rate calculation
baseline_stats AS (
  SELECT
    client,
    usp_standard_at_step AS usp_standard_baseline,
    usp_nonstandard_at_step AS usp_nonstandard_baseline,
    tcf_standard_at_step AS tcf_standard_baseline,
    gpp_standard_at_step AS gpp_standard_baseline,
    any_signal_at_step AS any_signal_baseline,
    avg_signal_count_at_step AS avg_signal_count_baseline
  FROM
    step_survival_stats
  WHERE
    redirect_step_number = 1
)

-- Final output with survival rates
SELECT
  ss.client,
  ss.redirect_step_number,
  ss.step_type,
  ss.total_urls_at_step,
  ss.total_pages_at_step,

  -- Signal counts and survival rates
  ss.usp_standard_at_step,
  SAFE_DIVIDE(ss.usp_standard_at_step, bs.usp_standard_baseline) AS usp_standard_survival_rate,

  ss.usp_nonstandard_at_step,
  SAFE_DIVIDE(ss.usp_nonstandard_at_step, bs.usp_nonstandard_baseline) AS usp_nonstandard_survival_rate,

  ss.tcf_standard_at_step,
  SAFE_DIVIDE(ss.tcf_standard_at_step, bs.tcf_standard_baseline) AS tcf_standard_survival_rate,

  ss.gpp_standard_at_step,
  SAFE_DIVIDE(ss.gpp_standard_at_step, bs.gpp_standard_baseline) AS gpp_standard_survival_rate,

  ss.any_signal_at_step,
  SAFE_DIVIDE(ss.any_signal_at_step, bs.any_signal_baseline) AS any_signal_survival_rate,

  -- Average signal degradation
  ss.avg_signal_count_at_step,
  bs.avg_signal_count_baseline,
  ss.avg_signal_count_at_step - bs.avg_signal_count_baseline AS signal_count_change,
  SAFE_DIVIDE(ss.avg_signal_count_at_step, bs.avg_signal_count_baseline) AS signal_count_retention_rate

FROM
  step_survival_stats ss
JOIN
  baseline_stats bs
USING (client)

ORDER BY
  client,
  redirect_step_number
