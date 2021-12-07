#standardSQL
# 17_07: Percentage of responses with via header
SELECT
  _TABLE_SUFFIX AS client,
  _cdn_provider AS cdn,
  COUNTIF(resp_via != '') AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(resp_via != '') * 100 / COUNT(0), 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client,
  cdn
ORDER BY
  total DESC
