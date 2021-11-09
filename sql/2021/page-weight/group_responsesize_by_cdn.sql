SELECT
  _TABLE_SUFFIX AS client,
  cdn,
  COUNT(0) AS requests,
  AVG(respSize) / 1024 AS resp_kbytes
FROM
  `httparchive.summary_requests.2021_07_01_*`,
  UNNEST(SPLIT(_cdn_provider, ', ')) AS cdn
GROUP BY
  client,
  cdn
ORDER BY
  requests DESC
