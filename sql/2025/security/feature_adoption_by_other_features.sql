#standardSQL
# Section: Drivers of security mechanism adoption - Other Headers?
# Question: Which features (mostly security headers) influence the adoption of other features?
# Note: Query seems unnatural after the port; Add other (new) features?
SELECT
  client,
  headername,
  COUNT(0) AS total_pages,
  COUNTIF(headername IN UNNEST(respHeaders)) AS total_with_header,
  SAFE_DIVIDE(COUNTIF(headername IN UNNEST(respHeaders)), COUNT(0)) AS pct,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    STARTS_WITH(url, 'https')
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_https,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Content-Security-Policy' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_csp,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Content-Security-Policy-Report-Only' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_csp_report_only,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Cross-Origin-Embedder-Policy' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_coep,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Cross-Origin-Opener-Policy' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_coop,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Cross-Origin-Resource-Policy' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_corp,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Expect-CT' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_expectct,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Feature-Policy' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_featurep,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Permissions-Policy' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_permissionsp,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Referrer-Policy' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_referrerp,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Report-To' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_reportto,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'Strict-Transport-Security' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_hsts,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'X-Content-Type-Options' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_xcto,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'X-Frame-Options' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_xfo,
  SAFE_DIVIDE(COUNTIF(
    headername IN UNNEST(respHeaders) AND
    'X-XSS-Protection' IN UNNEST(respHeaders)
  ), COUNTIF(headername IN UNNEST(respHeaders))) AS pct_header_and_xss
FROM
  UNNEST(['Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy', 'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To', 'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection']) AS headername,
  (
    SELECT
      ARRAY(SELECT h.name FROM UNNEST(r.response_headers) AS h) AS respHeaders,
      client,
      url
    FROM
      `httparchive.crawl.requests` AS r
    WHERE
      date = '2025-07-01' AND
      is_root_page AND
      is_main_document
  )
GROUP BY
  client,
  headername
ORDER BY
  client,
  headername
