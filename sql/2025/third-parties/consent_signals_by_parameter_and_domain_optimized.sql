#standardSQL
# Detailed breakdown of consent signals by individual parameters and top domains

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
    date = '2025-07-01' AND
    -- Pre-filter: only process URLs that contain consent-related parameters
    REGEXP_CONTAINS(url, r'[?&](us_privacy|ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string|gdpr|gdpr_consent|gdpr_pd|gpp|gpp_sid)=')
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

-- Single-pass parameter extraction using one comprehensive regex
parameter_extraction AS (
  SELECT
    r.client,
    canonicalDomain,
    category,
    rank_grouping,
    -- Extract all relevant parameters in one pass using REGEXP_EXTRACT_ALL
    REGEXP_EXTRACT_ALL(r.url, r'[?&](us_privacy|ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string|gdpr|gdpr_consent|gdpr_pd|gpp|gpp_sid)=') AS found_parameters
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

-- Flatten parameters and count occurrences
flattened_parameters AS (
  SELECT
    client,
    canonicalDomain,
    category,
    rank_grouping,
    param
  FROM
    parameter_extraction,
    UNNEST(found_parameters) AS param
),

-- Aggregate parameter counts
parameter_counts AS (
  SELECT
    client,
    canonicalDomain,
    category,
    rank_grouping,
    param,
    COUNT(0) AS param_count,
    COUNT(DISTINCT CONCAT(client, canonicalDomain)) AS domain_count
  FROM
    flattened_parameters
  GROUP BY
    client,
    canonicalDomain,
    category,
    rank_grouping,
    param
),

-- Get total request counts for percentage calculations (from ALL third-party requests, not pre-filtered)
totals AS (
  SELECT
    r.client,
    rank_grouping,
    COUNT(0) AS total_all_requests
  FROM
    `httparchive.crawl.requests` r
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
    r.date = '2025-07-01' AND
    p.rank <= rank_grouping
  GROUP BY
    r.client,
    rank_grouping
),

-- Categorize parameters
categorized_params AS (
  SELECT
    client,
    rank_grouping,
    param,
    CASE
      WHEN param = 'us_privacy' THEN 'USP Standard'
      WHEN param IN ('ccpa', 'usp_consent', 'uspString', 'uspConsent', 'ccpa_consent', 'usp', 'usprivacy', 'ccpaconsent', 'usp_string') THEN 'USP Non-Standard'
      WHEN param IN ('gdpr', 'gdpr_consent', 'gdpr_pd') THEN 'TCF Standard'
      WHEN param IN ('gpp', 'gpp_sid') THEN 'GPP Standard'
    END AS signal_category,
    SUM(param_count) AS total_requests,
    COUNT(DISTINCT canonicalDomain) AS domains_using
  FROM
    parameter_counts
  GROUP BY
    client,
    rank_grouping,
    param,
    signal_category
)

-- Parameter frequency analysis
SELECT
  'Parameter Frequency' AS analysis_type,
  client,
  rank_grouping,
  param AS parameter_name,
  signal_category,
  total_requests,
  domains_using,
  total_requests / totals.total_all_requests AS pct_of_all_requests
FROM
  categorized_params
JOIN
  totals
USING (client, rank_grouping)

UNION ALL

-- Top domains analysis (simplified)
SELECT
  'Top Domains' AS analysis_type,
  client,
  rank_grouping,
  canonicalDomain AS parameter_name,
  category AS signal_category,
  SUM(param_count) AS total_requests,
  COUNT(DISTINCT param) AS domains_using,
  SUM(param_count) / MAX(totals.total_all_requests) AS pct_of_all_requests
FROM
  parameter_counts
JOIN
  totals
USING (client, rank_grouping)
GROUP BY
  client,
  rank_grouping,
  canonicalDomain,
  category
HAVING
  SUM(param_count) > 0

ORDER BY
  analysis_type,
  client,
  rank_grouping,
  total_requests DESC
LIMIT 1000
