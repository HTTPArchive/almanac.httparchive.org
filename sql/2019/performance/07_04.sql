#standardSQL
# 07_04: % fast FID per PSI
SELECT
  ROUND(COUNTIF(fast_fid >= .95) * 100 / COUNT(0), 2) AS pct_fast_fid,
  ROUND(COUNTIF(NOT (slow_fid >= 0.05) AND NOT (fast_fid >= .95)) * 100 / COUNT(0), 2) AS pct_avg_fid,
  ROUND(COUNTIF(slow_fid >= 0.05) * 100 / COUNT(0), 2) AS pct_slow_fid
FROM
  `chrome-ux-report.materialized.metrics_summary`
WHERE
  date = '2019-07-01' AND
  fast_fid + avg_fid + slow_fid > 0
