#standardSQL
# TBT data by threshold

WITH tbt_stats AS (
  SELECT
    url,
    CAST(JSON_EXTRACT_SCALAR(report, "$.audits.total-blocking-time.numericValue") AS FLOAT64) AS tbtValue,
    CAST(JSON_EXTRACT_SCALAR(report, "$.audits.total-blocking-time.score") AS FLOAT64) AS tbtScore
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
)

SELECT
  CASE
    WHEN tbtScore < 0.5 THEN 'POOR'
    WHEN tbtScore < 0.9 THEN 'NI'
    ELSE 'GOOD'
  END AS tbt,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM
  tbt_stats
GROUP BY
  tbt
ORDER BY
  tbt
