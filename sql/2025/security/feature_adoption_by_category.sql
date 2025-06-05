#standardSQL
# Section: Drivers of security mechanism adoption - Website Category
# Question: How is security feature adoption and category of a website related?
# Note: Not all headers have their individual percentages
# Note: Currenly uses regex search on respOtherHeaders that can have false positives if a header name is used as a value of a header; could use the new response_header struct instead
# Note: Only on the main document (is_main_document)
CREATE TEMP FUNCTION getNumSecurityHeaders(headers STRING) AS (
  (
    SELECT
      COUNTIF(REGEXP_CONTAINS(headers, CONCAT('(?i)', headername, ' ')))
    FROM
      UNNEST([
        'Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy',
        'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To',
        'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection'
      ]) AS headername
  )
);

SELECT
  client,
  category,
  COUNT(0) AS total_pages_for_category,
  COUNTIF(STARTS_WITH(url, 'https')) AS freq_https,
  SAFE_DIVIDE(COUNTIF(STARTS_WITH(url, 'https')), COUNT(0)) AS pct_https,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)X-Frame-Options ')), COUNT(0)) AS pct_xfo,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Strict-Transport-Security ')), COUNT(0)) AS pct_hsts,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)X-Content-Type-Options ')), COUNT(0)) AS pct_xcto,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Expect-CT ')), COUNT(0)) AS pct_expectct,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy ')), COUNT(0)) AS pct_csp,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy-Report-Only ')), COUNT(0)) AS pct_cspro,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)X-XSS-Protection ')), COUNT(0)) AS pct_xss,
  AVG(getNumSecurityHeaders(respOtherHeaders)) AS avg_security_headers,
  APPROX_QUANTILES(getNumSecurityHeaders(respOtherHeaders), 1000)[OFFSET(500)] AS median_security_headers
FROM (
  SELECT
    client,
    SPLIT(parent_category, '/')[1] AS category,
    JSON_VALUE(r.summary, '$.respOtherHeaders') AS respOtherHeaders,
    url
  FROM
    `httparchive.all.requests` AS r
  INNER JOIN
    UNNEST(`httparchive.fn.GET_HOST_CATEGORIES`(url))
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document
)
GROUP BY
  client,
  category
ORDER BY
  client,
  total_pages_for_category DESC
