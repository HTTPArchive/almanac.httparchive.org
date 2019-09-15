# standard SQL
# 08_39b.sql
# 
# Calculate usage percentage for Use of SRI on subresources via Headers
#
# BigQuery usage notes: 
# == archive.summary_response_bodies =  71.5 GB usage (firstHtml partitioning)
# == archive.summary_requests = 117.5 GB 
#  

SELECT
  client,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)content-security-policy = ([^,\r\n]+)')) * 100 / COUNT(0),2) AS pct_all_csp,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)content-security-policy = .*require-sri-for*([^,\r\n]+)')) * 100 / COUNT(0),4) AS pct_csp_sri
FROM
  `httparchive.almanac.summary_requests`
WHERE
  firstHtml
GROUP BY
  client  
