#standardSQL
# Distribution of external stylesheet transfer size (compressed).
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(bytesCSS / 1024, 1000)[OFFSET(percentile * 10)] AS stylesheet_kbytes
FROM
  `httparchive.summary_pages.2019_07_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
