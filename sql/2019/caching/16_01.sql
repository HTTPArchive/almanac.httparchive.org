#standardSQL
# 16_01: TTL by resource
SELECT
  client,
  percentile,
  type,
  APPROX_QUANTILES(expAge, 1000)[OFFSET(percentile * 10)] AS ttl
FROM
  `httparchive.almanac.requests`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  date = '2019-07-01' AND
  expAge > 0
GROUP BY
  percentile,
  client,
  type
ORDER BY
  type,
  percentile,
  client
