SELECT
  _TABLE_SUFFIX AS client,
  cdn,
  COUNT(0) AS requests,
  AVG(respSize) / 1024 AS avg_resp_kbytes,
  APPROX_QUANTILES(respSize, 1000)[OFFSET(500)] / 1024 AS median_resp_kbytes
FROM
  `httparchive.summary_requests.2021_07_01_*`,
  UNNEST(SPLIT(_cdn_provider, ', ')) AS cdn
GROUP BY
  client,
  cdn
ORDER BY
  requests DESC
