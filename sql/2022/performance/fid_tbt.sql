SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(CAST(JSON_QUERY(report, '$.audits.total-blocking-time.numericValue') AS FLOAT64), 1000)[OFFSET(percentile * 10)] AS tbt
FROM
  `httparchive.lighthouse.2022_06_01_*`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
