#standardSQL
# Optimized: Consent signal survival rate through inclusion chains (memory-efficient)

CREATE TEMP FUNCTION extractConsentSignals(url STRING)
RETURNS STRUCT<
  has_usp_standard BOOL,
  has_usp_nonstandard BOOL,
  has_usp_nonstandard BOOL,
  has_tcf_standard BOOL,
  has_gpp_standard BOOL,
  has_any_signal BOOL
>
LANGUAGE js AS """
  try {
    const signals = {
      has_usp_standard: /[?&]us_privacy=/.test(url),
      has_usp_nonstandard: /[?&](ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string)=/.test(url),
      has_tcf_standard: /[?&](gdpr|gdpr_consent|gdpr_pd)=/.test(url),
      has_gpp_standard: /[?&](gpp|gpp_sid)=/.test(url)
    };

    signals.has_any_signal = signals.has_usp_standard ||
                            signals.has_usp_nonstandard ||
                            signals.has_tcf_standard ||
                            signals.has_gpp_standard;

    return signals;
  } catch (e) {
    return {
      has_usp_standard: false,
      has_usp_nonstandard: false,
      has_tcf_standard: false,
      has_gpp_standard: false,
      has_any_signal: false
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
    rank <= 10000  -- Aggressive filtering: top 10K only
),

-- Pre-filter to only requests with consent signals or initiator info
filtered_requests AS (
  SELECT
    r.client,
    r.page,
    r.url,
    NET.REG_DOMAIN(r.page) AS root_page,
    NET.REG_DOMAIN(r.url) AS third_party,
    NET.REG_DOMAIN(JSON_VALUE(r.payload, '$._initiator')) AS initiator_etld,
    extractConsentSignals(r.url) AS consent_signals
  FROM
    `httparchive.crawl.requests` r
  INNER JOIN
    pages p
  ON
    r.client = p.client AND r.page = p.page
  WHERE
    r.date = '2025-07-01' AND
    NET.REG_DOMAIN(r.page) != NET.REG_DOMAIN(r.url) AND  -- Third-party only
    (
      -- Only process requests with consent signals OR that are part of chains
      REGEXP_CONTAINS(r.url, r'[?&](us_privacy|ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string|gdpr|gdpr_consent|gdpr_pd|gpp|gpp_sid)=') OR
      JSON_VALUE(r.payload, '$._initiator') IS NOT NULL
    )
),

-- Simplified two-step chain analysis (avoid complex recursion)
step_1_requests AS (
  SELECT
    client,
    root_page,
    third_party,
    consent_signals,
    COUNT(0) AS step1_count
  FROM
    filtered_requests
  WHERE
    initiator_etld = root_page AND  -- Direct first-party to third-party requests
    consent_signals.has_any_signal = TRUE
  GROUP BY
    client,
    root_page,
    third_party,
    consent_signals
),

step_2_requests AS (
  SELECT
    fr.client,
    s1.root_page,
    s1.third_party AS step1_party,
    fr.third_party AS step2_party,
    s1.consent_signals AS step1_signals,
    fr.consent_signals AS step2_signals,
    COUNT(0) AS step2_count
  FROM
    filtered_requests fr
  INNER JOIN
    step_1_requests s1
  ON
    fr.client = s1.client AND
    fr.root_page = s1.root_page AND
    fr.initiator_etld = s1.third_party  -- Third-party chain
  GROUP BY
    fr.client,
    s1.root_page,
    s1.third_party,
    fr.third_party,
    s1.consent_signals,
    fr.consent_signals
),

-- Calculate survival stats by step
step_1_stats AS (
  SELECT
    client,
    1 AS step_number,

    COUNTIF(consent_signals.has_usp_standard) AS usp_standard_count,
    COUNTIF(consent_signals.has_usp_nonstandard) AS usp_nonstandard_count,
    COUNTIF(consent_signals.has_tcf_standard) AS tcf_standard_count,
    COUNTIF(consent_signals.has_gpp_standard) AS gpp_standard_count,
    COUNTIF(consent_signals.has_any_signal) AS any_signal_count,

    COUNT(0) AS total_requests,
    COUNT(DISTINCT root_page) AS total_pages
  FROM
    step_1_requests
  GROUP BY
    client
),

step_2_stats AS (
  SELECT
    client,
    2 AS step_number,

    COUNTIF(step2_signals.has_usp_standard) AS usp_standard_count,
    COUNTIF(step2_signals.has_usp_nonstandard) AS usp_nonstandard_count,
    COUNTIF(step2_signals.has_tcf_standard) AS tcf_standard_count,
    COUNTIF(step2_signals.has_gpp_standard) AS gpp_standard_count,
    COUNTIF(step2_signals.has_any_signal) AS any_signal_count,

    COUNT(0) AS total_requests,
    COUNT(DISTINCT root_page) AS total_pages
  FROM
    step_2_requests
  GROUP BY
    client
),

-- Combine step statistics
combined_stats AS (
  SELECT * FROM step_1_stats
  UNION ALL
  SELECT * FROM step_2_stats
),

-- Get baselines for survival rate calculation
baselines AS (
  SELECT
    client,
    usp_standard_count AS usp_standard_baseline,
    usp_nonstandard_count AS usp_nonstandard_baseline,
    tcf_standard_count AS tcf_standard_baseline,
    gpp_standard_count AS gpp_standard_baseline,
    any_signal_count AS any_signal_baseline
  FROM
    combined_stats
  WHERE
    step_number = 1
)

-- Final survival rate output (simplified)
SELECT
  cs.client,
  cs.step_number,
  cs.total_requests,
  cs.total_pages,

  -- Signal counts and survival rates
  cs.usp_standard_count,
  SAFE_DIVIDE(cs.usp_standard_count, b.usp_standard_baseline) AS usp_standard_survival_rate,

  cs.usp_nonstandard_count,
  SAFE_DIVIDE(cs.usp_nonstandard_count, b.usp_nonstandard_baseline) AS usp_nonstandard_survival_rate,

  cs.tcf_standard_count,
  SAFE_DIVIDE(cs.tcf_standard_count, b.tcf_standard_baseline) AS tcf_standard_survival_rate,

  cs.gpp_standard_count,
  SAFE_DIVIDE(cs.gpp_standard_count, b.gpp_standard_baseline) AS gpp_standard_survival_rate,

  cs.any_signal_count,
  SAFE_DIVIDE(cs.any_signal_count, b.any_signal_baseline) AS any_signal_survival_rate

FROM
  combined_stats cs
JOIN
  baselines b
USING (client)

ORDER BY
  client,
  step_number
