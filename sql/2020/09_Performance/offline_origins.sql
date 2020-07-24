#standardSQL
# Offline origins

SELECT
  COUNT(DISTINCT origin) AS total_origins,
  COUNT(DISTINCT IF(offlineDensity > 0, origin, NULL)) offline_origins
FROM
  `chrome-ux-report.materialized.metrics_summary`
WHERE
  date = '2020-06-01'