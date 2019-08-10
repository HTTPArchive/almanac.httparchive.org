#standardSQL
# 17_09: Percentage of responses with server-timing header
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(SUM(IF(LOWER(respOtherHeaders) LIKE "%server-timing%", 1, 0)) / COUNT(0), 4) AS pctServerTiming
FROM 
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client


