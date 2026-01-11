#standardSQL
# Consent signal survival rate through HTTP redirects (memory-efficient)

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
    if (!url || typeof url !== 'string') return {
      has_usp_standard: false, has_usp_nonstandard: false,
      has_tcf_standard: false, has_gpp_standard: false,
      has_any_signal: false, signal_count: 0
    };

    const signals = {
      has_usp_standard: /[?&]us_privacy=/.test(url),
      has_usp_nonstandard: /[?&](ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string)=/.test(url),
      has_tcf_standard: /[?&](gdpr|gdpr_consent|gdpr_pd)=/.test(url),
      has_gpp_standard: /[?&](gpp|gpp_sid)=/.test(url)
    };

    signals.signal_count = [
      signals.has_usp_standard, signals.has_usp_nonstandard,
      signals.has_tcf_standard, signals.has_gpp_standard
    ].filter(Boolean).length;

    signals.has_any_signal = signals.signal_count > 0;
    return signals;
  } catch (e) {
    return {
      has_usp_standard: false, has_usp_nonstandard: false,
      has_tcf_standard: false, has_gpp_standard: false,
      has_any_signal: false, signal_count: 0
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
    date = '2025-07-01' AND
    rank <= 100000  -- Expanded to top 100K sites
),

-- Pre-filter requests with redirects and potential consent signals
requests_with_redirects AS (
  SELECT
    r.client,
    r.page,
    r.url AS final_url,
    JSON_EXTRACT_SCALAR(r.summary, '$.redirectUrl') AS redirect_url,
    NET.REG_DOMAIN(r.url) AS final_domain
  FROM
    `httparchive.crawl.requests` r
  INNER JOIN
    pages p
  ON
    r.client = p.client AND r.page = p.page
  WHERE
    r.date = '2025-07-01' AND
    NET.REG_DOMAIN(r.page) != NET.REG_DOMAIN(r.url) AND  -- Third-party only
    JSON_EXTRACT_SCALAR(r.summary, '$.redirectUrl') IS NOT NULL AND
    JSON_EXTRACT_SCALAR(r.summary, '$.redirectUrl') != '' AND
    (
      -- Pre-filter: only URLs with consent signals in final URL or redirect URL
      REGEXP_CONTAINS(r.url, r'[?&](us_privacy|ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string|gdpr|gdpr_consent|gdpr_pd|gpp|gpp_sid)=') OR
      REGEXP_CONTAINS(JSON_EXTRACT_SCALAR(r.summary, '$.redirectUrl'), r'[?&](us_privacy|ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string|gdpr|gdpr_consent|gdpr_pd|gpp|gpp_sid)=')
    )
),

-- Simplified redirect parsing - 2 step analysis
redirect_steps AS (
  SELECT
    client,
    page,
    final_url,
    final_domain,

    -- Step 1: Original redirect URL (before redirect)
    redirect_url AS step1_url,

    -- Step 2: Final URL (after redirect)
    final_url AS step2_url
  FROM
    requests_with_redirects
  WHERE
    redirect_url IS NOT NULL AND
    redirect_url != ''
),

-- Extract consent signals for each step
signals_by_step AS (
  SELECT
    client,
    page,
    final_domain,

    -- Step 1 signals (original redirect URL)
    step1_url,
    extractConsentSignals(step1_url) AS step1_signals,

    -- Step 2 signals (final URL after redirect)
    step2_url,
    extractConsentSignals(step2_url) AS step2_signals
  FROM
    redirect_steps
  WHERE
    step1_url IS NOT NULL
),

-- Calculate step-wise aggregations (memory efficient)
step_aggregations AS (
  -- Step 1 stats (original redirect URL)
  SELECT
    client,
    1 AS redirect_step,
    'original' AS step_type,

    COUNTIF(step1_signals.has_usp_standard) AS usp_standard_count,
    COUNTIF(step1_signals.has_usp_nonstandard) AS usp_nonstandard_count,
    COUNTIF(step1_signals.has_tcf_standard) AS tcf_standard_count,
    COUNTIF(step1_signals.has_gpp_standard) AS gpp_standard_count,
    COUNTIF(step1_signals.has_any_signal) AS any_signal_count,

    AVG(step1_signals.signal_count) AS avg_signal_count,
    COUNT(0) AS total_urls,
    COUNT(DISTINCT page) AS total_pages
  FROM
    signals_by_step
  WHERE
    step1_signals.has_any_signal = TRUE  -- Only analyze chains that start with signals
  GROUP BY
    client

  UNION ALL

  -- Step 2 stats (final URL after redirect)
  SELECT
    client,
    2 AS redirect_step,
    'final' AS step_type,

    COUNTIF(step2_signals.has_usp_standard) AS usp_standard_count,
    COUNTIF(step2_signals.has_usp_nonstandard) AS usp_nonstandard_count,
    COUNTIF(step2_signals.has_tcf_standard) AS tcf_standard_count,
    COUNTIF(step2_signals.has_gpp_standard) AS gpp_standard_count,
    COUNTIF(step2_signals.has_any_signal) AS any_signal_count,

    AVG(step2_signals.signal_count) AS avg_signal_count,
    COUNT(0) AS total_urls,
    COUNT(DISTINCT page) AS total_pages
  FROM
    signals_by_step
  WHERE
    step1_signals.has_any_signal = TRUE  -- Same baseline
  GROUP BY
    client
),

-- Calculate baselines (step 1)
baselines AS (
  SELECT
    client,
    usp_standard_count AS usp_standard_baseline,
    usp_nonstandard_count AS usp_nonstandard_baseline,
    tcf_standard_count AS tcf_standard_baseline,
    gpp_standard_count AS gpp_standard_baseline,
    any_signal_count AS any_signal_baseline,
    avg_signal_count AS avg_signal_count_baseline
  FROM
    step_aggregations
  WHERE
    redirect_step = 1
)

-- Final output with survival rates
SELECT
  sa.client,
  sa.redirect_step,
  sa.step_type,
  sa.total_urls,
  sa.total_pages,

  -- Signal survival rates
  sa.usp_standard_count,
  SAFE_DIVIDE(sa.usp_standard_count, b.usp_standard_baseline) AS usp_standard_survival_rate,

  sa.usp_nonstandard_count,
  SAFE_DIVIDE(sa.usp_nonstandard_count, b.usp_nonstandard_baseline) AS usp_nonstandard_survival_rate,

  sa.tcf_standard_count,
  SAFE_DIVIDE(sa.tcf_standard_count, b.tcf_standard_baseline) AS tcf_standard_survival_rate,

  sa.gpp_standard_count,
  SAFE_DIVIDE(sa.gpp_standard_count, b.gpp_standard_baseline) AS gpp_standard_survival_rate,

  sa.any_signal_count,
  SAFE_DIVIDE(sa.any_signal_count, b.any_signal_baseline) AS any_signal_survival_rate,

  -- Signal count preservation
  sa.avg_signal_count,
  b.avg_signal_count_baseline,
  sa.avg_signal_count - b.avg_signal_count_baseline AS signal_count_change,
  SAFE_DIVIDE(sa.avg_signal_count, b.avg_signal_count_baseline) AS signal_count_retention_rate

FROM
  step_aggregations sa
JOIN
  baselines b
USING (client)

ORDER BY
  client,
  redirect_step
