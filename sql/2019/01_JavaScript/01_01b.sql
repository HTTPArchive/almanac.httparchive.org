#standardSQL
# 01_01b: Distribution of JS bytes by client
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(ROUND(bytesJs / 1024, 2), 1000)[OFFSET(percentile * 10)] AS js_kbytes
FROM
  `httparchive.summary_pages.2019_07_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client