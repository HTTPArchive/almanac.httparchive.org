#standardSQL
# 04_16: Video format sizes
SELECT
  percentile,
  client,
  format,
  ROUND(APPROX_QUANTILES(respSize, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS kbytes
FROM
  `httparchive.almanac.requests`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  type = 'video'
GROUP BY
  percentile,
  client,
  format
ORDER BY
  percentile,
  client,
  format