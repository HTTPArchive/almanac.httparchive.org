#standardSQL
# 08_18: CSP 'unsafe-eval' usage
SELECT
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) csp_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'unsafe-eval')) unsafe_eval_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?default-src?([^,|;]+)')), 'unsafe-eval')) defaultsrc_unsafe_eval_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'unsafe-eval')) scriptsrc_unsafe_eval_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?style-src?([^,|;]+)')), 'unsafe-eval')) stylesrc_unsafe_eval_count
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE 
  firstHtml = true
