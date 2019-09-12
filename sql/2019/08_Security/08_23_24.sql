#standardSQL
# 08_20: HSTS subdomains and preload usage
SELECT
  COUNT(0) as site_count,
  COUNTIF(REGEXP_CONTAINS(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?strict-transport-security =([^,]+)'), r'(?i)max-age')) hsts_max_age_count,
  COUNTIF(REGEXP_CONTAINS(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?strict-transport-security =([^,]+)'), r'(?i)includeSubDomains')) hsts_subdomains_count,
  COUNTIF(REGEXP_CONTAINS(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?strict-transport-security =([^,]+)'), r'(?i)preload')) hsts_preload_count
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE 
   firstHtml = true
