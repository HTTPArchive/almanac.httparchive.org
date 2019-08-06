# standard SQL
# 08_24-34Sum.sql
#
# Calculate usage percentage for each of the 10 metrics 08.25-34 metrics in one run
#
# BigQuery usage notes: 
# == archive.summary_response_bodies =  71.5 GB usage (firstHtml partitioning)
# == archive.summary_requests = 117.5 GB 
#  
# cross-origin-opener-policy - only 6 instances of this data across the archive
# sec-fetch-* - zero instances of this data across the archive

SELECT
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)nel =')) * 100 / COUNT(0),2) AS pct_nel,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)report-to = ')) * 100 / COUNT(0),2) AS pct_report_to,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)referrer-policy = ')) * 100 / COUNT(0),2) AS pct_referrer_policy,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)feature-policy = ')) * 100 / COUNT(0),2) AS pct_feature_policy,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-content-type-options = ')) * 100 / COUNT(0),2) AS pct_xcontent_type_options,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-xss-protection = ')) * 100 / COUNT(0),2) AS pct_x_xss_protection,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)x-frame-options = ')) * 100 / COUNT(0),2) AS pct_x_frame_options,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)cross-origin-resource-policy = ')) * 100 / COUNT(0),2) AS pct_x_origin_resource_policy,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)cross-origin-opener-policy = ')) * 100 / COUNT(0),2) AS pct_x_origin_opener_policy,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)sec-fetch-[dest|mode|site|user] = ')) * 100 / COUNT(0),2) AS pct_sec_fetches
FROM
  `httparchive.almanac.summary_response_bodies`
 WHERE
   firstHtml
