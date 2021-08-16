#standardSQL
# 07_07: TTFB distribution
SELECT
  fast,
  avg,
  slow
FROM (
  SELECT
    ROUND(fast_ttfb * 100, 2) AS fast,
    ROUND(avg_ttfb * 100, 2) AS avg,
    ROUND(slow_ttfb * 100, 2) AS slow,
    ROW_NUMBER() OVER (ORDER BY fast_ttfb DESC) AS row,
    COUNT(0) OVER (PARTITION BY 0) AS n
  FROM
    `chrome-ux-report.materialized.metrics_summary`
  WHERE
    date = '2019-07-01' AND
    fast_ttfb + avg_ttfb + slow_ttfb > 0
  ORDER BY
    fast DESC)
WHERE
  MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
