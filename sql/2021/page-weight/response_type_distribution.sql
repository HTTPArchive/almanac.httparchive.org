#standardSQL
# 18_04: Distribution of response size by response type
SELECT
  _TABLE_SUFFIX AS client,
  percentile,
  type,
  APPROX_QUANTILES(respSize / 1024, 1000)[OFFSET(percentile * 10)] AS resp_size
FROM
  `httparchive.summary_requests.2021_07_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile,
  type
ORDER BY
  client,
  type,
  percentile
