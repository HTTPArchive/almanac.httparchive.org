#standardSQL
# 08_31: Groupings of "x-frame-options" parsed values by percentage
#    
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  client, 
  SUM(COUNT(0)) OVER (PARTITION BY client) AS client_tot,
  xframe_val,
  count(0) as xframe_val_freq,
  ROUND(COUNT(0)*100/SUM(COUNT(0)) OVER (PARTITION BY client),2) as xss_val_pct 
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'x-frame-options = ([^,\r\n]+)')) AS xframe_val
WHERE
  firstHtml
GROUP BY
  client, xframe_val
ORDER BY
  client, xframe_val_freq DESC
