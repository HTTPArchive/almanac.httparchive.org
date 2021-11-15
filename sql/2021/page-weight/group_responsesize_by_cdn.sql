SELECT
  _TABLE_SUFFIX AS client,
  AVG(respSize) / 1024 AS resp_size,
  _cdn_provider AS _cdn_provider
FROM
  `httparchive.summary_requests.2021_07_01_*`
GROUP BY
  client,
  _cdn_provider
