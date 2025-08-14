#standardSQL
# Section: Drivers of security mechanism adoption - Website Category
# Question: How is security feature adoption and category of a website related?
# Note: Not all headers have their individual percentages
# Note: Only on the main document (is_main_document)
CREATE TEMP FUNCTION getNumSecurityHeaders(headers ARRAY<STRING>) AS (
  (
    SELECT
      COUNT(*)
    FROM
      UNNEST([
        'content-security-policy', 'content-security-policy-report-only', 'cross-origin-embedder-policy', 'cross-origin-opener-policy',
        'cross-origin-resource-policy', 'expect-ct', 'feature-policy', 'permissions-policy', 'referrer-policy', 'report-to',
        'strict-transport-security', 'x-content-type-options', 'x-frame-options', 'x-xss-protection'
      ]) AS headername
      WHERE
        headername IN UNNEST(headers)
  )
);

SELECT
  client,
  category,
  COUNT(0) AS total_pages_for_category,
  COUNTIF(STARTS_WITH(url, 'https')) AS freq_https,
  SAFE_DIVIDE(COUNTIF(STARTS_WITH(url, 'https')), COUNT(0)) AS pct_https,
  SAFE_DIVIDE(COUNTIF('x-frame-options' IN UNNEST(respHeaders)), COUNT(0)) AS pct_xfo,
  SAFE_DIVIDE(COUNTIF('strict-transport-security' IN UNNEST(respHeaders)), COUNT(0)) AS pct_hsts,
  SAFE_DIVIDE(COUNTIF('x-content-type-options' IN UNNEST(respHeaders)), COUNT(0)) AS pct_xcto,
  SAFE_DIVIDE(COUNTIF('expect-ct' IN UNNEST(respHeaders)), COUNT(0)) AS pct_expectct,
  SAFE_DIVIDE(COUNTIF('content-security-policy' IN UNNEST(respHeaders)), COUNT(0)) AS pct_csp,
  SAFE_DIVIDE(COUNTIF('content-security-policy-report-only' IN UNNEST(respHeaders)), COUNT(0)) AS pct_cspro,
  SAFE_DIVIDE(COUNTIF('x-xss-protection' IN UNNEST(respHeaders)), COUNT(0)) AS pct_xss,
  AVG(getNumSecurityHeaders(respHeaders)) AS avg_security_headers,
  APPROX_QUANTILES(getNumSecurityHeaders(respHeaders), 1000)[OFFSET(500)] AS median_security_headers
FROM (
  SELECT
    client,
    SPLIT(parent_category, '/')[1] AS category,
    ARRAY(SELECT h.name from UNNEST(r.response_headers) as h) AS respHeaders,
    url
  FROM
    `httparchive.crawl.requests` AS r
  INNER JOIN
    UNNEST(`httparchive.fn.GET_HOST_CATEGORIES`(url))
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    is_main_document
)
GROUP BY
  client,
  category
ORDER BY
  client,
  total_pages_for_category DESC
