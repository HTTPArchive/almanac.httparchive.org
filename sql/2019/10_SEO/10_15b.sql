#standardSQL

# % of websites classified as fast/avg/slow by form factor

SELECT
  device,
  ROUND(COUNTIF(fast_fcp >= .9 AND fast_fid >= .95) * 100 / COUNT(0), 2) AS pct_fast,
  ROUND(COUNTIF(NOT(slow_fcp >= .1 OR slow_fid >= 0.05) AND NOT(fast_fcp >= .9 AND fast_fid >= .95)) * 100 / COUNT(0), 2) AS pct_avg,
  ROUND(COUNTIF(slow_fcp >= .1 OR slow_fid >= 0.05) * 100 / COUNT(0), 2) AS pct_slow
FROM
  `chrome-ux-report.materialized.device_summary`
WHERE
  yyyymm = '201907'
GROUP BY
  device
