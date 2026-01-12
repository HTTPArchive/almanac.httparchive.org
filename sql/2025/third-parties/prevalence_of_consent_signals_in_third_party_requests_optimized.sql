#standardSQL
# Prevalence of specific consent signals (USP, TCF, GPP) in third-party requests

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

requests AS (
  SELECT
    client,
    page,
    url
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01'
),

third_party AS (
  SELECT
    domain,
    canonicalDomain,
    category,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2025-07-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    canonicalDomain,
    category
  HAVING
    page_usage >= 50
),

totals AS (
  SELECT
    r.client,
    rank_grouping,
    COUNT(DISTINCT r.page) AS total_pages,
    COUNT(0) AS total_requests
  FROM
    requests r
  INNER JOIN
    pages p
  ON
    r.client = p.client AND r.page = p.page,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    p.rank <= rank_grouping
  GROUP BY
    r.client,
    rank_grouping
),

third_party_requests AS (
  SELECT
    r.client,
    r.page,
    r.url,
    canonicalDomain,
    category,
    rank_grouping
  FROM
    requests r
  INNER JOIN
    pages p
  ON
    r.client = p.client AND r.page = p.page
  INNER JOIN
    third_party tp
  ON
    NET.HOST(r.url) = NET.HOST(tp.domain),
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    p.rank <= rank_grouping
),

-- Single-pass consent signal detection using one comprehensive regex
consent_signals AS (
  SELECT
    client,
    page,
    url,
    canonicalDomain,
    category,
    rank_grouping,

    -- Extract all consent parameters in one pass
    REGEXP_EXTRACT_ALL(url, r'[?&](us_privacy|ccpa|usp_consent|uspString|sst\.us_privacy|uspConsent|ccpa_consent|AV_CCPA|usp|usprivacy|_fw_us_privacy|D9v\.us_privacy|cnsnt|ccpaconsent|usp_string|gdpr|gdpr_consent|gdpr_pd|gpp|gpp_sid)=') AS found_params,

    -- Boolean flags derived from the extracted parameters (computed once)
    REGEXP_CONTAINS(url, r'[?&]us_privacy=') AS has_usp_standard,
    REGEXP_CONTAINS(url, r'[?&](ccpa|usp_consent|uspString|sst\.us_privacy|uspConsent|ccpa_consent|AV_CCPA|usp|usprivacy|_fw_us_privacy|D9v\.us_privacy|cnsnt|ccpaconsent|usp_string)=') AS has_usp_nonstandard,
    REGEXP_CONTAINS(url, r'[?&](gdpr|gdpr_consent|gdpr_pd)=') AS has_tcf_standard,
    REGEXP_CONTAINS(url, r'[?&](gpp|gpp_sid)=') AS has_gpp_standard
  FROM
    third_party_requests
  WHERE
    -- Pre-filter to reduce data processing
    REGEXP_CONTAINS(url, r'[?&](us_privacy|ccpa|usp_consent|uspString|sst\.us_privacy|uspConsent|ccpa_consent|AV_CCPA|usp|usprivacy|_fw_us_privacy|D9v\.us_privacy|cnsnt|ccpaconsent|usp_string|gdpr|gdpr_consent|gdpr_pd|gpp|gpp_sid)=')
),

-- Add computed flag for any consent signal
signals_with_any AS (
  SELECT
    *,
    (has_usp_standard OR has_usp_nonstandard OR has_tcf_standard OR has_gpp_standard) AS has_any_consent_signal
  FROM
    consent_signals
),

-- Create a single aggregation table to avoid repetitive calculations
signal_aggregates AS (
  SELECT
    client,
    rank_grouping,
    -- USP Standard metrics
    COUNTIF(has_usp_standard) AS usp_standard_requests,
    COUNT(DISTINCT CASE WHEN has_usp_standard THEN page END) AS usp_standard_pages,
    COUNT(DISTINCT CASE WHEN has_usp_standard THEN canonicalDomain END) AS usp_standard_domains,

    -- USP Non-Standard metrics
    COUNTIF(has_usp_nonstandard) AS usp_nonstandard_requests,
    COUNT(DISTINCT CASE WHEN has_usp_nonstandard THEN page END) AS usp_nonstandard_pages,
    COUNT(DISTINCT CASE WHEN has_usp_nonstandard THEN canonicalDomain END) AS usp_nonstandard_domains,

    -- TCF Standard metrics
    COUNTIF(has_tcf_standard) AS tcf_standard_requests,
    COUNT(DISTINCT CASE WHEN has_tcf_standard THEN page END) AS tcf_standard_pages,
    COUNT(DISTINCT CASE WHEN has_tcf_standard THEN canonicalDomain END) AS tcf_standard_domains,

    -- GPP Standard metrics
    COUNTIF(has_gpp_standard) AS gpp_standard_requests,
    COUNT(DISTINCT CASE WHEN has_gpp_standard THEN page END) AS gpp_standard_pages,
    COUNT(DISTINCT CASE WHEN has_gpp_standard THEN canonicalDomain END) AS gpp_standard_domains,

    -- Any consent signal metrics
    COUNTIF(has_any_consent_signal) AS any_consent_requests,
    COUNT(DISTINCT CASE WHEN has_any_consent_signal THEN page END) AS any_consent_pages,
    COUNT(DISTINCT CASE WHEN has_any_consent_signal THEN canonicalDomain END) AS any_consent_domains,

    -- Totals for this filtered dataset
    COUNT(0) AS total_third_party_requests
  FROM
    signals_with_any
  GROUP BY
    client,
    rank_grouping
)

-- Final output using UNNEST to avoid repetitive UNION ALL
SELECT
  agg.client,
  agg.rank_grouping,
  signal_data.signal_type,
  signal_data.requests_with_signal,
  agg.total_third_party_requests,
  signal_data.requests_with_signal / agg.total_third_party_requests AS pct_requests_with_signal,
  signal_data.pages_with_signal,
  totals.total_pages,
  signal_data.pages_with_signal / totals.total_pages AS pct_pages_with_signal,
  signal_data.domains_with_signal
FROM
  signal_aggregates agg
JOIN
  totals
USING (client, rank_grouping)
CROSS JOIN
  UNNEST([
    STRUCT('USP Standard' AS signal_type, usp_standard_requests AS requests_with_signal, usp_standard_pages AS pages_with_signal, usp_standard_domains AS domains_with_signal),
    STRUCT('USP Non-Standard' AS signal_type, usp_nonstandard_requests AS requests_with_signal, usp_nonstandard_pages AS pages_with_signal, usp_nonstandard_domains AS domains_with_signal),
    STRUCT('TCF Standard' AS signal_type, tcf_standard_requests AS requests_with_signal, tcf_standard_pages AS pages_with_signal, tcf_standard_domains AS domains_with_signal),
    STRUCT('GPP Standard' AS signal_type, gpp_standard_requests AS requests_with_signal, gpp_standard_pages AS pages_with_signal, gpp_standard_domains AS domains_with_signal),
    STRUCT('Any Consent Signal' AS signal_type, any_consent_requests AS requests_with_signal, any_consent_pages AS pages_with_signal, any_consent_domains AS domains_with_signal)
  ]) AS signal_data

ORDER BY
  client,
  rank_grouping,
  signal_type
