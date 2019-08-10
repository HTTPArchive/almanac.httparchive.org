#standardSQL
# 17_08: Percentage of responses with keep-alive header
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(SUM(IF(LOWER(respOtherHeaders) LIKE "%keep-alive%", 1, 0)) / COUNT(0), 4) AS pctKeepAlive
FROM 
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client
