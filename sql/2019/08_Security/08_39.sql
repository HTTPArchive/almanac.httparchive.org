# standard SQL
# 08_39.sql
# 
# Calculate usage percentage for Use of SRI on subresources via HTML link(s)/script(s) tag + integrity attribute
#
# BigQuery usage notes: 
# == archive.summary_response_bodies =  17.4 TB usage (firstHtml partitioning)
#  


SELECT
  client,
  ROUND(COUNTIF(REGEXP_CONTAINS(body, '(?i)<[link|script] .*[^">]')) * 100 / COUNT(0),2) AS pct_linkscript_tot,
  ROUND(COUNTIF(REGEXP_CONTAINS(body, '(?i)<[link|script] .*integrity=".*[^">]')) * 100 / COUNT(0),2) AS pct_linkscript_integrity
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
GROUP BY
  client  
