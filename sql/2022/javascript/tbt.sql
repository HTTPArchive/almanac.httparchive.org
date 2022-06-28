#standardSQL
# TBT

WITH tbt_stats AS (
  SELECT
    url,
    CAST(JSON_EXTRACT_SCALAR(report, '$.audits.total-blocking-time.numericValue') AS FLOAT64) AS tbtValue
  FROM
    `httparchive.lighthouse.2022_06_01_mobile`
)

SELECT
  percentile,
  APPROX_QUANTILES(tbtValue, 1000)[OFFSET(percentile * 10)] AS tbt
FROM
  tbt_stats,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
