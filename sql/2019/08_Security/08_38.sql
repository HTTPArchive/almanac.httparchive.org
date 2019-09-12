# standard SQL
# 08_38.sql
# 
# Calculate usage percentage for set-cookie and the "prefix" values of "__Secure" and "__Host-" groupings
#
# BigQuery usage notes: 
# == archive.summary_response_bodies =  71.5 GB usage (firstHtml partitioning)
# == archive.summary_requests = 117.5 GB 
#  
# minimal number of responses so for now moved the rounding out to 4 digits
#
### Zero data found - so need to see if the parsing/search location is incorrect vs. truly low use

SELECT
  client,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)set-cookie = ([^,\r\n]+)')) * 100 / COUNT(0),2) AS pct_all_set_cookie,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)set-cookie = .*__secure.*([^,\r\n]+)')) * 100 / COUNT(0),4) AS pct_prefix_secure,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)set-cookie = .*__host-.*([^,\r\n]+)')) * 100 / COUNT(0),4) AS pct_prefix_host
FROM
  `httparchive.almanac.summary_requests`
WHERE
  firstHtml
GROUP BY
  client  
