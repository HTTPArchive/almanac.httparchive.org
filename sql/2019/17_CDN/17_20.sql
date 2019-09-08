#standardSQL
# 17_20: Percentage of responses with s-maxage directive
SELECT
  _TABLE_SUFFIX AS client,
  _cdn_provider AS cdn,
  COUNTIF(LOWER(resp_cache_control) LIKE "%s-maxage%") AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(LOWER(resp_cache_control) LIKE "%s-maxage%") * 100 / COUNT(0), 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client,
  cdn
ORDER BY
  total DESC