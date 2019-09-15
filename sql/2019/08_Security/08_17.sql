#standardSQL
# 08_17: CSP 'unsafe-inline' usage
SELECT
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) csp_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'unsafe-inline')) unsafe_inline_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?default-src?([^,|;]+)')), 'unsafe-inline')) defaultsrc_unsafe_inline_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'unsafe-inline')) scriptsrc_unsafe_inline_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?style-src?([^,|;]+)')), 'unsafe-inline')) stylesrc_unsafe_inline_count
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE 
  firstHtml = true
