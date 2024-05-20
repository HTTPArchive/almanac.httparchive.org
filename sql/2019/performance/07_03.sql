#standardSQL
# 07_03: % fast FCP per PSI
SELECT
  ROUND(COUNTIF(fast_fcp >= .75) * 100 / COUNT(0), 2) AS pct_fast_fcp,
  ROUND(COUNTIF(NOT (slow_fcp >= .25) AND NOT (fast_fcp >= .75)) * 100 / COUNT(0), 2) AS pct_avg_fcp,
  ROUND(COUNTIF(slow_fcp >= .25) * 100 / COUNT(0), 2) AS pct_slow_fcp
FROM
  `chrome-ux-report.materialized.metrics_summary`
WHERE
  date = '2019-07-01'
