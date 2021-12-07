#standardSQL
# Offline origins

SELECT
  total_origins,
  offline_origins,
  offline_origins / total_origins AS pct_offline_origins
FROM (
  SELECT
    COUNT(DISTINCT origin) AS total_origins,
    COUNT(DISTINCT IF(offlineDensity > 0, origin, NULL)) AS offline_origins
  FROM
    `chrome-ux-report.materialized.metrics_summary`
  WHERE
    date = '2020-08-01'
)
