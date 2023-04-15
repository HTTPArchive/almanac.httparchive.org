#standardSQL
# 07_01b: FCP desktop distribution
SELECT
  fast,
  avg,
  slow
FROM (
  SELECT
    device,
    ROUND(SAFE_DIVIDE(fast_fcp, fast_fcp + avg_fcp + slow_fcp) * 100, 2) AS fast,
    ROUND(SAFE_DIVIDE(avg_fcp, fast_fcp + avg_fcp + slow_fcp) * 100, 2) AS avg,
    ROUND(SAFE_DIVIDE(slow_fcp, fast_fcp + avg_fcp + slow_fcp) * 100, 2) AS slow,
    ROW_NUMBER() OVER (ORDER BY fast_fcp DESC) AS row,
    COUNT(0) OVER () AS n
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm = '201907' AND
    fast_fcp + avg_fcp + slow_fcp > 0 AND
    device = 'desktop'
  ORDER BY
    fast DESC
)
WHERE
  MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
