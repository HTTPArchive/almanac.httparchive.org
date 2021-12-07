#standardSQL
# 17_10: Percentage of responses with vary header
SELECT
  _TABLE_SUFFIX AS client,
  _cdn_provider AS cdn,
  COUNTIF(resp_vary != '') AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(resp_vary != '') * 100 / COUNT(0), 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client,
  cdn
ORDER BY
  total DESC
