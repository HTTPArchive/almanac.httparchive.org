#standardSQL
# 07_05b: % fast FID per PSI by device
SELECT
  device,
  ROUND(COUNTIF(fast_fcp >= .9 AND fast_fid >= .95) * 100 / COUNT(0), 2) AS pct_fast,
  ROUND(COUNTIF(NOT (slow_fcp >= .1 OR slow_fid >= 0.05) AND NOT (fast_fcp >= .9 AND fast_fid >= .95)) * 100 / COUNT(0), 2) AS pct_avg,
  ROUND(COUNTIF(slow_fcp >= .1 OR slow_fid >= 0.05) * 100 / COUNT(0), 2) AS pct_slow
FROM (
  SELECT
    device,
    SAFE_DIVIDE(fast_fcp, fast_fcp + avg_fcp + slow_fcp) AS fast_fcp,
    SAFE_DIVIDE(avg_fcp, fast_fcp + avg_fcp + slow_fcp) AS avg_fcp,
    SAFE_DIVIDE(slow_fcp, fast_fcp + avg_fcp + slow_fcp) AS slow_fcp,
    SAFE_DIVIDE(fast_fid, fast_fid + avg_fid + slow_fid) AS fast_fid,
    SAFE_DIVIDE(avg_fid, fast_fid + avg_fid + slow_fid) AS avg_fid,
    SAFE_DIVIDE(slow_fid, fast_fid + avg_fid + slow_fid) AS slow_fid
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm = '201907' AND
    fast_fid + avg_fid + slow_fid > 0 AND
    device IN ('desktop', 'phone')
)
GROUP BY
  device
