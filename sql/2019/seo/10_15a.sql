#standardSQL
# 10_15a: % of websites classified as fast/avg/slow
SELECT
  ROUND(COUNTIF(fast_fcp >= .9 AND fast_fid >= .95) * 100 / COUNT(0), 2) AS pct_fast,
  ROUND(COUNTIF(NOT (slow_fcp >= .1 OR slow_fid >= 0.05) AND NOT (fast_fcp >= .9 AND fast_fid >= .95)) * 100 / COUNT(0), 2) AS pct_avg,
  ROUND(COUNTIF(slow_fcp >= .1 OR slow_fid >= 0.05) * 100 / COUNT(0), 2) AS pct_slow
FROM
  `chrome-ux-report.materialized.metrics_summary`
WHERE
  date = '2019-07-01'
