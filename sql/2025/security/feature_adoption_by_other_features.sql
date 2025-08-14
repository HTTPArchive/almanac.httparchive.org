#standardSQL
# Section: Drivers of security mechanism adoption - Other Headers?
# Question: Which features (mostly security headers) influence the adoption of other features?
# Note: Query seems unnatural after the port; Add other (new) features?
SELECT
  client,
  headername,
  COUNT(0) AS total_pages,
  COUNTIF(headername IN UNNEST(respHeaders)) AS total_with_header,
  SAFE_DIVIDE(COUNTIF(headername in UNNEST(respHeaders)), COUNT(0)) AS pct,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    STARTS_WITH(url, 'https')
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_https,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Content-Security-Policy' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_csp,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Content-Security-Policy-Report-Only' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_csp_report_only,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Cross-Origin-Embedder-Policy' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_coep,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Cross-Origin-Opener-Policy' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_coop,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Cross-Origin-Resource-Policy' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_corp,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Expect-CT' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_expectct,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Feature-Policy' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_featurep,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Permissions-Policy' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_permissionsp,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Referrer-Policy' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_referrerp,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Report-To' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_reportto,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'Strict-Transport-Security' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_hsts,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'X-Content-Type-Options' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_xcto,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'X-Frame-Options' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_xfo,
  SAFE_DIVIDE(COUNTIF(
    headername in UNNEST(respHeaders) AND
    'X-XSS-Protection' in UNNEST(respHeaders)
  ), COUNTIF(headername in UNNEST(respHeaders))) AS pct_header_and_xss
FROM
  UNNEST(['Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy', 'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To', 'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection']) AS headername,
(
  SELECT
  ARRAY(SELECT h.name from UNNEST(r.response_headers) as h) AS respHeaders,
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
