#standardSQL
# 08_30: Groupings of "x-xss-protection" parsed values buckets
#   
#    Updated query for the dynamic grouping
#    Left the ";" values together and truncated the "report=(distinct values)" 
# 
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  client, 
  SUM(COUNT(0)) OVER (PARTITION BY client) AS client_tot,
  xss_val,
  count(0) as xss_val_freq,
  ROUND(COUNT(0)*100/SUM(COUNT(0)) OVER (PARTITION BY client),2) as xss_val_pct 
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'x-xss-protection = (.*report=|[^,\r\n]*)')) AS xss_val
WHERE
  firstHtml
GROUP BY
  client, xss_val
ORDER BY
  client, xss_val_freq DESC
