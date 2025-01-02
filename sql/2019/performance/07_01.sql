#standardSQL
# 07_01: FCP distribution
SELECT
  fast,
  avg,
  slow
FROM (
  SELECT
    ROUND(fast_fcp * 100, 2) AS fast,
    ROUND(avg_fcp * 100, 2) AS avg,
    ROUND(slow_fcp * 100, 2) AS slow,
    ROW_NUMBER() OVER (ORDER BY fast_fcp DESC) AS row,
    COUNT(0) OVER () AS n
  FROM
    `chrome-ux-report.materialized.metrics_summary`
  WHERE
    date = '2019-07-01' AND
    fast_fcp + avg_fcp + slow_fcp > 0
  ORDER BY
    fast DESC
)
WHERE
  MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
