#standardSQL
# 17_cdn_security_features_adoption.sql: CDN Security Features Adoption
#
# Rationale: Security is a crucial aspect of content delivery. This query analyzes
# the adoption of various security features across CDNs, including HSTS, CSP, XSS
# protection, and other security headers. This helps understand which CDNs are
# leading in security implementations.
#
# Expected insights:
# - Which CDNs implement the most comprehensive security headers
# - Adoption rates of specific security features (HSTS, CSP, etc.)
# - Comparison between CDN and origin server security implementations
# - Trends in security header adoption for 2025

SELECT
  IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn_provider,
  COUNT(DISTINCT page) AS total_pages,

  -- Overall security header presence
  COUNT(DISTINCT CASE WHEN (
    REGEXP_CONTAINS(TO_JSON_STRING(response_headers),
      r'(?i)"strict-transport-security"|"content-security-policy"|"x-xss-protection"|"x-frame-options"|"x-content-type-options"|"referrer-policy"|"permissions-policy"')
  ) THEN page END) AS pages_with_any_security_headers,

  ROUND(
    (COUNT(DISTINCT CASE WHEN (
      REGEXP_CONTAINS(TO_JSON_STRING(response_headers),
        r'(?i)"strict-transport-security"|"content-security-policy"|"x-xss-protection"|"x-frame-options"|"x-content-type-options"|"referrer-policy"|"permissions-policy"')
    ) THEN page END) * 100.0 / COUNT(DISTINCT page)), 2
  ) AS security_headers_adoption_rate_pct,

  -- Specific security headers breakdown
  COUNT(DISTINCT CASE WHEN REGEXP_CONTAINS(TO_JSON_STRING(response_headers), r'(?i)"strict-transport-security"')
    THEN page END) AS pages_with_hsts,
  COUNT(DISTINCT CASE WHEN REGEXP_CONTAINS(TO_JSON_STRING(response_headers), r'(?i)"content-security-policy"')
    THEN page END) AS pages_with_csp,
  COUNT(DISTINCT CASE WHEN REGEXP_CONTAINS(TO_JSON_STRING(response_headers), r'(?i)"x-frame-options"')
    THEN page END) AS pages_with_xframe,
  COUNT(DISTINCT CASE WHEN REGEXP_CONTAINS(TO_JSON_STRING(response_headers), r'(?i)"x-content-type-options"')
    THEN page END) AS pages_with_xcontent,
  COUNT(DISTINCT CASE WHEN REGEXP_CONTAINS(TO_JSON_STRING(response_headers), r'(?i)"referrer-policy"')
    THEN page END) AS pages_with_referrer_policy,
  COUNT(DISTINCT CASE WHEN REGEXP_CONTAINS(TO_JSON_STRING(response_headers), r'(?i)"permissions-policy"')
    THEN page END) AS pages_with_permissions_policy,

  -- Calculate percentages for each header
  ROUND((COUNT(DISTINCT CASE WHEN REGEXP_CONTAINS(TO_JSON_STRING(response_headers), r'(?i)"strict-transport-security"')
    THEN page END) * 100.0 / COUNT(DISTINCT page)), 2) AS hsts_pct,
  ROUND((COUNT(DISTINCT CASE WHEN REGEXP_CONTAINS(TO_JSON_STRING(response_headers), r'(?i)"content-security-policy"')
    THEN page END) * 100.0 / COUNT(DISTINCT page)), 2) AS csp_pct,
  ROUND((COUNT(DISTINCT CASE WHEN REGEXP_CONTAINS(TO_JSON_STRING(response_headers), r'(?i)"x-frame-options"')
    THEN page END) * 100.0 / COUNT(DISTINCT page)), 2) AS xframe_pct
FROM `httparchive.crawl.requests`
WHERE date = '2025-07-01' AND
  is_main_document = true
GROUP BY cdn_provider
HAVING
  total_pages > 100  -- Filter out CDNs with very small sample sizes
ORDER BY security_headers_adoption_rate_pct DESC,
  total_pages DESC
LIMIT 100