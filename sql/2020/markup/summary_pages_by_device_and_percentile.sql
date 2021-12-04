#standardSQL
# summary_pages data grouped by device and percentiles M107

SELECT
  percentile,
  _TABLE_SUFFIX AS client,

  APPROX_QUANTILES(bytesHtml, 1000)[OFFSET(percentile * 10)] AS bytesHtml

FROM
  `httparchive.summary_pages.2020_08_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  client
