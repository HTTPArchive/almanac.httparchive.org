
#standardSQL
# 08_33: Groupings of "cross-origin-opener-policy" parsed values by percentage
#   Move to dynamic parsing for now
#    
# 
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#       0 rows available some far
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB
# 

SELECT
  client, 
  SUM(COUNT(0)) OVER (PARTITION BY client) AS client_tot,
  xcoop_val,
  count(0) as xcoop_val_freq,
  ROUND(COUNT(0)*100/SUM(COUNT(0)) OVER (PARTITION BY client),2) as xcoop_val_pct 
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'cross-origin-opener-policy = ([^,\r\n]+)')) AS xcoop_val
WHERE
  firstHtml
GROUP BY
  client, xcoop_val
ORDER BY
  client, xcoop_val_freq DESC
