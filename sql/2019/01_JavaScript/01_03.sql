#standardSQL
# 01_03: Distribution of JS requests
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(reqJs, 1000)[OFFSET(percentile * 10)] AS distribution_js_reqs
FROM
  `httparchive.summary_pages.2019_07_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
