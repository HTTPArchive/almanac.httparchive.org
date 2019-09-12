#standardSQL
# 08_35.sql
# 
# Calculate usage percentage for set-cookie and the "httponly" flag
#
# BigQuery usage notes: 
# == archive.summary_response_bodies =  71.5 GB usage (firstHtml partitioning)
# == archive.summary_requests = 117.5 GB 
#  
# minimal number of responses so for now moved the rounding out to 4 digits
#
### Super low data set - so need to see if the parsing/search location is incorrect vs. truly low use

SELECT
  client,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)set-cookie = ([^,\r\n]+)')) * 100 / COUNT(0),2) AS pct_all_set_cookie,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)set-cookie = .*httponly.*([^,\r\n]+)')) * 100 / COUNT(0),4) AS pct_httponly
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
GROUP BY
  client  
