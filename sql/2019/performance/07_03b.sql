#standardSQL
# 07_03b: % fast FCP per PSI by device
SELECT
  device,
  ROUND(COUNTIF(fast_fcp >= .75) * 100 / COUNT(0), 2) AS pct_fast_fcp,
  ROUND(COUNTIF(NOT (slow_fcp >= .25) AND NOT (fast_fcp >= .75)) * 100 / COUNT(0), 2) AS pct_avg_fcp,
  ROUND(COUNTIF(slow_fcp >= .25) * 100 / COUNT(0), 2) AS pct_slow_fcp
FROM (
  SELECT
    device,
    SAFE_DIVIDE(fast_fcp, fast_fcp + avg_fcp + slow_fcp) AS fast_fcp,
    SAFE_DIVIDE(avg_fcp, fast_fcp + avg_fcp + slow_fcp) AS avg_fcp,
    SAFE_DIVIDE(slow_fcp, fast_fcp + avg_fcp + slow_fcp) AS slow_fcp
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm = '201907' AND
    device IN ('desktop', 'phone')
)
GROUP BY
  device
