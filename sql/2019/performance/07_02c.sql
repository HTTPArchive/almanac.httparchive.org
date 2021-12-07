#standardSQL
# 07_02c: FID phone distribution
SELECT
  fast,
  avg,
  slow
FROM (
  SELECT
    device,
    ROUND(SAFE_DIVIDE(fast_fid, fast_fid + avg_fid + slow_fid) * 100, 2) AS fast,
    ROUND(SAFE_DIVIDE(avg_fid, fast_fid + avg_fid + slow_fid) * 100, 2) AS avg,
    ROUND(SAFE_DIVIDE(slow_fid, fast_fid + avg_fid + slow_fid) * 100, 2) AS slow,
    ROW_NUMBER() OVER (ORDER BY fast_fid DESC) AS row,
    COUNT(0) OVER () AS n
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm = '201907' AND
    fast_fid + avg_fid + slow_fid > 0 AND
    device = 'phone'
  ORDER BY
    fast DESC)
WHERE
  MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
