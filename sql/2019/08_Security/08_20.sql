#standardSQL
# 08_20: CSP 'trusted-types' usage
SELECT
  COUNT(*) site_count,
  COUNTIF(csp IS NOT NULL) csp_count,
  COUNTIF(csp_report_only IS NOT NULL) csp_report_only_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wcontent-security-policy =([^,]+)')), 'trusted-types')) csp_trusted_type_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wcontent-security-policy-report-only =([^,]+)')), 'trusted-types')) csp_report_only_trusted_type_count
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE 
  firstHtml = true
