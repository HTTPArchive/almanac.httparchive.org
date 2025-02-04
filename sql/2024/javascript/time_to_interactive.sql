#standardSQL
# Percentiles of time to interactive
SELECT
  client,
  percentile,
  ROUND(APPROX_QUANTILES(tti, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS tti
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(IFNULL(JSON_EXTRACT(report, '$.audits.consistently-interactive.numericValue'), JSON_EXTRACT(report, '$.audits.interactive.numericValue')) AS FLOAT64) AS tti
  FROM
    `httparchive.lighthouse.2024_06_01_*`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
