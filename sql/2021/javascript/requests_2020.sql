#standardSQL
# Sum of JS requests per page (2020)
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(reqJS, 1000)[OFFSET(percentile * 10)] AS js_requests
FROM
  `httparchive.summary_pages.2020_08_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
