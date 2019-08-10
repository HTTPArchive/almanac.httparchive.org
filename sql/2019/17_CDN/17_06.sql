#standardSQL
# 17_06: Percentage of responses with timing-allow-origin header
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(SUM(IF(LOWER(respOtherHeaders) LIKE "%timing-allow-origin%", 1, 0)) / COUNT(0), 4) AS pctTimingAllowOrigin
FROM 
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client
