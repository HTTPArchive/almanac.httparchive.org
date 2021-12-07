#standardSQL
# 07_06: % offline websites
SELECT
  COUNTIF(offlineDensity > 0) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(offlineDensity > 0) * 100 / COUNT(0), 2) AS pct
FROM
  `chrome-ux-report.materialized.metrics_summary`
WHERE
  date = '2019-07-01'
