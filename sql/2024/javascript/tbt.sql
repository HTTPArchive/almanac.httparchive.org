#standardSQL
# TBT

WITH tbt_stats AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    CAST(JSON_EXTRACT_SCALAR(report, '$.audits.total-blocking-time.numericValue') AS FLOAT64) AS tbtValue
  FROM
    `httparchive.lighthouse.2024_06_01_*`
)

SELECT
  client,
  percentile,
  APPROX_QUANTILES(tbtValue, 1000)[OFFSET(percentile * 10)] AS tbt
FROM
  tbt_stats,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
