#standardSQL
# Distribution of unused CSS request bytes per page
SELECT
  _TABLE_SUFFIX AS client,
  percentile,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.unused-css-rules.details.overallSavingsBytes') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS css_kilobytes
FROM
  `httparchive.lighthouse.2022_06_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
