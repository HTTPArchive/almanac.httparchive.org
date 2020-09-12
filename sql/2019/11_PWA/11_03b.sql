#standardSQL
# 11_03b: Distribution of SW payload sizes
SELECT
  percentile,
  client,
  APPROX_QUANTILES(respSize, 1000)[OFFSET(percentile * 10)] AS bytes
FROM
  `httparchive.almanac.service_workers`
JOIN
  `httparchive.almanac.requests`
USING (client, page, url),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
