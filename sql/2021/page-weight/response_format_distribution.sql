#standardSQL
# 18_03: Distribution of response size by response format 2021
SELECT
  _TABLE_SUFFIX AS client,
  percentile,
  format,
  APPROX_QUANTILES(respSize / 1024, 1000)[OFFSET(percentile * 10)] AS resp_size
FROM
  `httparchive.summary_requests.2021_07_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile,
  format
ORDER BY
  format,
  client,
  percentile
