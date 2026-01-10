#standardSQL
# Working version: Consent signal survival rate through HTTP redirects

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

-- First, find all third-party requests with consent signals (regardless of redirects)
initial_consent_requests AS (
  SELECT
    r.client,
    r.page,
    r.url,
    extractConsentSignals(r.url) AS url_signals
  FROM
    `httparchive.crawl.requests` r
  INNER JOIN
    pages p
  ON
    r.client = p.client AND r.page = p.page
  WHERE
    r.date = '2025-07-01' AND
    NET.REG_DOMAIN(r.page) != NET.REG_DOMAIN(r.url) AND  -- Third-party only
    REGEXP_CONTAINS(r.url, r'[?&](us_privacy|ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string|gdpr|gdpr_consent|gdpr_pd|gpp|gpp_sid)=')
),

-- Now look for those same requests that ALSO have redirect chains
requests_with_redirects AS (
  SELECT
    icr.client,
    icr.page,
    icr.url,
    icr.url_signals,
    r.summary,
    JSON_EXTRACT_SCALAR(r.summary, '$.redirectUrl') AS redirect_url
  FROM
    initial_consent_requests icr
  INNER JOIN
    `httparchive.crawl.requests` r
  ON
    icr.client = r.client AND
    icr.page = r.page AND
    icr.url = r.url
  WHERE
    r.date = '2025-07-01' AND
    JSON_EXTRACT_SCALAR(r.summary, '$.redirectUrl') IS NOT NULL AND
    JSON_EXTRACT_SCALAR(r.summary, '$.redirectUrl') != ''
),

-- Parse redirect chains (simplified - just look at redirect URL and final URL)
parsed_redirects AS (
  SELECT
    client,
    page,
    url AS final_url,
    url_signals AS final_signals,

    -- Extract redirect URL
    redirect_url AS redirect_url,

    -- Simple redirect count (1 = single redirect)
    CASE WHEN redirect_url IS NOT NULL AND redirect_url != '' THEN 1 ELSE 0 END AS redirect_count
  FROM
    requests_with_redirects
  WHERE
    redirect_url IS NOT NULL AND
    redirect_url != ''
),

-- Extract signals from redirect steps
redirect_analysis AS (
  SELECT
    client,
    page,
    final_url,
    final_signals,
    redirect_url,
    redirect_count,
    extractConsentSignals(redirect_url) AS redirect_signals
  FROM
    parsed_redirects
  WHERE
    redirect_url IS NOT NULL
)

-- Final analysis comparing signals across redirect steps
SELECT
  client,

  -- Overall statistics
  COUNT(0) AS total_redirect_chains_with_consent,
  COUNT(DISTINCT page) AS pages_with_redirect_chains,
  AVG(redirect_count) AS avg_redirect_count,

  -- Step 1 (redirect URL) signal analysis
  COUNTIF(redirect_signals.has_any_signal) AS step1_requests_with_signals,
  COUNTIF(redirect_signals.has_usp_standard) AS step1_usp_standard,
  COUNTIF(redirect_signals.has_usp_nonstandard) AS step1_usp_nonstandard,
  COUNTIF(redirect_signals.has_tcf_standard) AS step1_tcf_standard,
  COUNTIF(redirect_signals.has_gpp_standard) AS step1_gpp_standard,

  -- Final URL signal analysis
  COUNTIF(final_signals.has_any_signal) AS final_requests_with_signals,
  COUNTIF(final_signals.has_usp_standard) AS final_usp_standard,
  COUNTIF(final_signals.has_usp_nonstandard) AS final_usp_nonstandard,
  COUNTIF(final_signals.has_tcf_standard) AS final_tcf_standard,
  COUNTIF(final_signals.has_gpp_standard) AS final_gpp_standard,

  -- Survival rates (what percentage of signals make it to final URL)
  SAFE_DIVIDE(COUNTIF(final_signals.has_any_signal), COUNT(0)) AS overall_signal_survival_rate,
  SAFE_DIVIDE(COUNTIF(final_signals.has_usp_standard), COUNTIF(redirect_signals.has_usp_standard)) AS usp_standard_survival_rate,
  SAFE_DIVIDE(COUNTIF(final_signals.has_tcf_standard), COUNTIF(redirect_signals.has_tcf_standard)) AS tcf_standard_survival_rate,
  SAFE_DIVIDE(COUNTIF(final_signals.has_gpp_standard), COUNTIF(redirect_signals.has_gpp_standard)) AS gpp_standard_survival_rate

FROM
  redirect_analysis
GROUP BY
  client
ORDER BY
  client
