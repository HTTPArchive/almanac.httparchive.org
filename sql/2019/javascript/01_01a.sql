#standardSQL
# 01_01a: Distribution of JS bytes
SELECT
  percentile,
  APPROX_QUANTILES(ROUND(bytesJs / 1024, 2), 1000)[OFFSET(percentile * 10)] AS js_kbytes
FROM
  `httparchive.summary_pages.2019_07_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
