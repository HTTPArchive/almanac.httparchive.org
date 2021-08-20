#standardSQL
# Analysis of how certain features influence the adoption of other features
SELECT
  _TABLE_SUFFIX AS client,
  headername,
  COUNT(0) AS total_pages,
  COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' '))) AS total_with_header,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' '))), COUNT(0)) AS pct,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND STARTS_WITH(url, 'https')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_https,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_csp,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Content-Security-Policy-Report-Only ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_csp_report_only,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Cross-Origin-Embedder-Policy ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_coep,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Cross-Origin-Opener-Policy ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_coop,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Cross-Origin-Resource-Policy ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_corp,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Expect-CT ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_expectct,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Feature-Policy ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_featurep,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Permissions-Policy ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_permissionsp,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Referrer-Policy ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_referrerp,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Report-To ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_reportto,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)Strict-Transport-Security ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_hsts,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)X-Content-Type-Options ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_xcto,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)X-Frame-Options ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_xfo,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND REGEXP_CONTAINS(respOtherHeaders, '(?i)X-XSS-Protection ')), COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')))) AS pct_header_and_xss
FROM
  `httparchive.summary_requests.2020_08_01_*`,
  UNNEST(['Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy', 'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To', 'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection']) AS headername
WHERE
  firstHtml
GROUP BY
  client,
  headername
ORDER BY
  client,
  headername
