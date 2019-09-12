#standardSQL
# 08_42: Groupings of "clear site data" parsed values by percentage
#    
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  client, 
  SUM(COUNT(0)) OVER (PARTITION BY client) AS client_tot,
  clear_site_data_val,
  count(0) as clear_site_data_val_freq,
  ROUND(COUNT(0)*100/SUM(COUNT(0)) OVER (PARTITION BY client),2) as clear_site_data_val_pct 
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'clear-site-data = ([^,\r\n]+)')) AS clear_site_data_val
WHERE
  firstHtml
GROUP BY
  client, clear_site_data_val
ORDER BY
  client, clear_site_data_val_freq DESC
