#standardSQL
# Security feature adoption grouped by sites frequently visited from different countries

CREATE TEMP FUNCTION getNumSecurityHeaders(headers STRING) AS ((
  SELECT
    COUNTIF(REGEXP_CONTAINS(headers, CONCAT('(?i)', headername, ' ')))
  FROM
    UNNEST(['Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy', 'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To', 'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection']) AS headername
)
);

SELECT
  client,
  country,
  COUNT(0) AS total_pages_for_country,
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
    r._TABLE_SUFFIX AS client,
    `chrome-ux-report.experimental`.GET_COUNTRY(country_code) AS country,
    respOtherHeaders,
    r.urlShort AS url,
    firstHtml
  FROM
    `httparchive.summary_requests.2020_08_01_*` AS r
  INNER JOIN
    `chrome-ux-report.experimental.country` AS c
  ON r.urlShort = CONCAT(c.origin, '/')
  WHERE
    firstHtml AND
    yyyymm = 202008
)
GROUP BY
  client,
  country
ORDER BY
  client,
  total_pages_for_country DESC
