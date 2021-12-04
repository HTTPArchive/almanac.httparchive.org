#standardSQL
# 07_14: Percentiles of visually complete metric
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  ROUND(APPROX_QUANTILES(visualComplete, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS visually_complete
FROM
  `httparchive.summary_pages.2019_07_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
