#standardSQL
# 17_06: Percentage of responses with timing-allow-origin header
SELECT
  _TABLE_SUFFIX AS client,
  _cdn_provider AS cdn,
  COUNTIF(LOWER(respOtherHeaders) LIKE "%timing-allow-origin%") AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(LOWER(respOtherHeaders) LIKE "%timing-allow-origin%") * 100 / COUNT(0), 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client,
  cdn
ORDER BY
  total DESC
