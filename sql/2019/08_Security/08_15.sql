#standardSQL
# 08_15: CSP script-src directive with nonce or sha
SELECT
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) csp_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'sha256|sha384|sha512')) csp_script_sha_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'nonce-'))  csp_script_nonce_count
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE 
  firstHtml = true 
