#standardSQL
# 07_04c: % fast FID per PSI by ECT
SELECT
  speed,
  ROUND(COUNTIF(fast_fid >= .95) * 100 / COUNT(0), 2) AS pct_fast_fid,
  ROUND(COUNTIF(NOT (slow_fid >= .05) AND NOT (fast_fid >= .95)) * 100 / COUNT(0), 2) AS pct_avg_fid,
  ROUND(COUNTIF(slow_fid >= .05) * 100 / COUNT(0), 2) AS pct_slow_fid
FROM (
  SELECT
    effective_connection_type.name AS speed,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start < 100, bin.density, 0)), SUM(bin.density)), 4) AS fast_fid,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start >= 100 AND bin.start < 300, bin.density, 0)), SUM(bin.density)), 4) AS avg_fid,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start >= 300, bin.density, 0)), SUM(bin.density)), 4) AS slow_fid
  FROM
    `chrome-ux-report.all.201907`,
    UNNEST(experimental.first_input_delay.histogram.bin) AS bin
  GROUP BY
    origin,
    speed
)
WHERE
  fast_fid + avg_fid + slow_fid > 0
GROUP BY
  speed
ORDER BY
  pct_fast_fid DESC
