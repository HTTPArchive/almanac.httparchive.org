#standardSQL
# 08_15-16: Hash/nonce CSP directives
SELECT
  client,
  csp_count,
  csp_script_sha_count,
  csp_script_nonce_count,
  total,
  ROUND(csp_count * 100 / total, 2) AS pct_csp,
  ROUND(csp_script_sha_count * 100 / total, 2) AS pct_csp_script_sha,
  ROUND(csp_script_nonce_count * 100 / total, 2) AS pct_csp_script_nonce
FROM (
  SELECT
    client,
    COUNT(0) AS total,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) AS csp_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'sha256|sha384|sha512')) AS csp_script_sha_count,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'nonce-')) AS csp_script_nonce_count
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    firstHtml
  GROUP BY
    client
)
