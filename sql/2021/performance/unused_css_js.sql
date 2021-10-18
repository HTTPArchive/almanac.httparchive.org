# standardSQL
# Distribution of unused CSS and JS

SELECT
  percentile,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, "$.audits.unused-javascript.details.overallSavingsBytes") AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS js_kilobytes,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, "$.audits.unused-css-rules.details.overallSavingsBytes") AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS css_kilobytes
FROM
  `httparchive.lighthouse.2021_07_01_mobile`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
