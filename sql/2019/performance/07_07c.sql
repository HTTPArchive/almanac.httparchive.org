#standardSQL
# 07_07c: TTFB phone distribution
SELECT
  fast,
  avg,
  slow
FROM (
  SELECT
    device,
    ROUND(SAFE_DIVIDE(fast_ttfb, fast_ttfb + avg_ttfb + slow_ttfb) * 100, 2) AS fast,
    ROUND(SAFE_DIVIDE(avg_ttfb, fast_ttfb + avg_ttfb + slow_ttfb) * 100, 2) AS avg,
    ROUND(SAFE_DIVIDE(slow_ttfb, fast_ttfb + avg_ttfb + slow_ttfb) * 100, 2) AS slow,
    ROW_NUMBER() OVER (ORDER BY fast_ttfb DESC) AS row,
    COUNT(0) OVER (PARTITION BY 0) AS n
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm = '201907' AND
    fast_ttfb + avg_ttfb + slow_ttfb > 0 AND
    device = 'phone'
  ORDER BY
    fast DESC)
WHERE
  MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
