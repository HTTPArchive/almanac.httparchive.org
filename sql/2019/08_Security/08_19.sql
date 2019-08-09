#standardSQL
# 08_19: CSP 'strict-dynamic' usage
SELECT
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) csp_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(respOtherHeaders), 'strict-dynamic')) strict_dynamic_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?script-src?([^,|;]+)')), 'strict-dynamic')) scriptsrc_strict_dynamic_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =') AND REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?default-src?([^,|;]+)')), 'strict-dynamic')) defaultsrc_strict_dynamic_count
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE 
  firstHtml = true 
