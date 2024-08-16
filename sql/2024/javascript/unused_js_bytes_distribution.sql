#standardSQL
# Distribution of unused JS request bytes per page
SELECT
  _TABLE_SUFFIX AS client,
  percentile,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.unused-javascript.details.overallSavingsBytes') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS js_kilobytes
FROM
  `httparchive.lighthouse.2024_06_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
