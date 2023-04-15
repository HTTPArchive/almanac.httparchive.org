#standardSQL
# 07_03c: % fast FCP per PSI by ECT
SELECT
  speed,
  ROUND(COUNTIF(fast_fcp >= .75) * 100 / COUNT(0), 2) AS pct_fast_fcp,
  ROUND(COUNTIF(NOT (slow_fcp >= .25) AND NOT (fast_fcp >= .75)) * 100 / COUNT(0), 2) AS pct_avg_fcp,
  ROUND(COUNTIF(slow_fcp >= .25) * 100 / COUNT(0), 2) AS pct_slow_fcp
FROM (
  SELECT
    effective_connection_type.name AS speed,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start < 1000, bin.density, 0)), SUM(bin.density)), 4) AS fast_fcp,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start >= 1000 AND bin.start < 3000, bin.density, 0)), SUM(bin.density)), 4) AS avg_fcp,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start >= 3000, bin.density, 0)), SUM(bin.density)), 4) AS slow_fcp
  FROM
    `chrome-ux-report.all.201907`,
    UNNEST(first_contentful_paint.histogram.bin) AS bin
  GROUP BY
    origin,
    speed
)
GROUP BY
  speed
ORDER BY
  pct_fast_fcp DESC
