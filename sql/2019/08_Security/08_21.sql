#standardSQL
# 08_20: CSP 'upgrade-insecure-requests' usage
SELECT
  COUNT(*) site_count,
  COUNTIF(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wcontent-security-policy =([^,]+)') IS NOT NULL) csp_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wcontent-security-policy =([^,]+)') ), 'upgrade-insecure-requests')) csp_upgrade_insecure_requests_count
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE 
  firstHtml = true 
