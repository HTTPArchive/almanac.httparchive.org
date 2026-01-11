#standardSQL
# Basic consent signal analysis (simplified version to ensure data returns)

WITH pages AS (
  SELECT
    client,
    page,
    rank
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    rank <= 50000  -- Expand to top 50K sites
),

-- Find requests with consent signals (no redirect filtering)
consent_requests AS (
  SELECT
    r.client,
    r.page,
    r.url,
    NET.REG_DOMAIN(r.page) AS page_domain,
    NET.REG_DOMAIN(r.url) AS url_domain,

    -- Extract consent signals
    REGEXP_CONTAINS(r.url, r'[?&]us_privacy=') AS has_usp_standard,
    REGEXP_CONTAINS(r.url, r'[?&](ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string)=') AS has_usp_nonstandard,
    REGEXP_CONTAINS(r.url, r'[?&](gdpr|gdpr_consent|gdpr_pd)=') AS has_tcf_standard,
    REGEXP_CONTAINS(r.url, r'[?&](gpp|gpp_sid)=') AS has_gpp_standard,

    -- Check if request has redirects
    JSON_EXTRACT(r.summary, '$.redirects') IS NOT NULL AND
    TO_JSON_STRING(JSON_EXTRACT(r.summary, '$.redirects')) != '[]' AS has_redirects
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
      REGEXP_CONTAINS(r.url, r'[?&]us_privacy=') OR
      REGEXP_CONTAINS(r.url, r'[?&](ccpa|usp_consent|uspString|uspConsent|ccpa_consent|usp|usprivacy|ccpaconsent|usp_string)=') OR
      REGEXP_CONTAINS(r.url, r'[?&](gdpr|gdpr_consent|gdpr_pd)=') OR
      REGEXP_CONTAINS(r.url, r'[?&](gpp|gpp_sid)=')
    )
),

-- Add any consent signal flag
requests_with_signals AS (
  SELECT
    *,
    (has_usp_standard OR has_usp_nonstandard OR has_tcf_standard OR has_gpp_standard) AS has_any_signal
  FROM
    consent_requests
)

-- Basic analysis
SELECT
  client,

  -- Overall counts
  COUNT(0) AS total_requests_with_consent_signals,
  COUNT(DISTINCT page) AS total_pages_with_consent_signals,
  COUNT(DISTINCT url_domain) AS total_domains_with_consent_signals,

  -- Signal type breakdown
  COUNTIF(has_usp_standard) AS usp_standard_requests,
  COUNTIF(has_usp_nonstandard) AS usp_nonstandard_requests,
  COUNTIF(has_tcf_standard) AS tcf_standard_requests,
  COUNTIF(has_gpp_standard) AS gpp_standard_requests,

  -- Percentage breakdown
  COUNTIF(has_usp_standard) / COUNT(0) AS pct_usp_standard,
  COUNTIF(has_usp_nonstandard) / COUNT(0) AS pct_usp_nonstandard,
  COUNTIF(has_tcf_standard) / COUNT(0) AS pct_tcf_standard,
  COUNTIF(has_gpp_standard) / COUNT(0) AS pct_gpp_standard,

  -- Redirect availability
  COUNTIF(has_redirects) AS requests_with_redirects,
  COUNTIF(has_redirects) / COUNT(0) AS pct_requests_with_redirects

FROM
  requests_with_signals
GROUP BY
  client
ORDER BY
  client
