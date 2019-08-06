#standardSQL

# CruX speed metrics (FCP, server response time)

SELECT
  ROUND(COUNTIF(slow_fp >= 0.10) * 100 / COUNT(0), 2) AS pct_slow_fp,
  ROUND(COUNTIF(slow_fcp >= 0.10) * 100 / COUNT(0), 2) AS pct_slow_fcp,
  ROUND(COUNTIF(slow_dcl >= 0.10) * 100 / COUNT(0), 2) AS pct_slow_dcl,
  ROUND(COUNTIF(slow_ol >= 0.10) * 100 / COUNT(0), 2) AS pct_slow_ol
FROM
  `chrome-ux-report.materialized.metrics_summary`
