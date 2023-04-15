#standardSQL
# 07_04b: % fast FID per PSI by device
SELECT
  device,
  ROUND(COUNTIF(fast_fid >= .95) * 100 / COUNT(0), 2) AS pct_fast_fid,
  ROUND(COUNTIF(NOT (slow_fid >= .05) AND NOT (fast_fid >= .95)) * 100 / COUNT(0), 2) AS pct_avg_fid,
  ROUND(COUNTIF(slow_fid >= .05) * 100 / COUNT(0), 2) AS pct_slow_fid
FROM (
  SELECT
    device,
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
