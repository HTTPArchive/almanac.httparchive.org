#standardSQL
# 08_30: Groupings of "x-xss-protection" parsed values buckets
#   
#    Updated query for the dynamic grouping
#    Left the ";" values together and truncated the "report=(distinct values)" 
# 
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  val,
  COUNT(0) AS freq,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.almanac.summary_requests`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'x-xss-protection = (.*report=|[^,\r\n]*)')) AS val
WHERE
  firstHtml
GROUP BY
  val
ORDER BY
  freq DESC
