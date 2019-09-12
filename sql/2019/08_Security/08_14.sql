#standardSQL
# 08_14: Frame-ancestor CSP directive
SELECT
  COUNT(*) as site_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), r'frame-ancestors') AND REGEXP_CONTAINS(LOWER(respOtherHeaders), 'content-security-policy =')) csp_frame_ancestors_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), r'content-security-policy =') AND ENDS_WITH(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wframe-ancestors([^,|;]+)'), '\'none\'')) csp_frame_ancestors_none_count,
  COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), r'content-security-policy =') AND ENDS_WITH(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\Wframe-ancestors([^,|;]+)'), '\'self\'')) csp_frame_ancestors_self_count
FROM 
  `httparchive.summary_requests.2019_07_01_*`
WHERE 
  firstHtml = true
