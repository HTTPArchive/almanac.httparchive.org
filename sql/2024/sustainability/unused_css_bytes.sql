#standardSQL
# Distribution of unused CSS request bytes per page

SELECT
  client,
  percentile,
  APPROX_QUANTILES(CAST(JSON_VALUE(lighthouse, '$.audits.unused-css-rules.details.overallSavingsBytes') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS css_kilobytes
FROM
  `httparchive.all.pages`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2024-06-01'
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
