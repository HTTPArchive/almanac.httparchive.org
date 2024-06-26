#standardSQL
# 07_08c: % fast TTFB by ECT
SELECT
  speed,
  ROUND(COUNTIF(fast_ttfb >= .9) * 100 / COUNT(0), 2) AS pct_fast_ttfb,
  ROUND(COUNTIF(NOT (slow_ttfb >= .1) AND NOT (fast_ttfb >= .9)) * 100 / COUNT(0), 2) AS pct_avg_ttfb,
  ROUND(COUNTIF(slow_ttfb >= .1) * 100 / COUNT(0), 2) AS pct_slow_ttfb
FROM (
  SELECT
    effective_connection_type.name AS speed,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start < 200, bin.density, 0)), SUM(bin.density)), 4) AS fast_ttfb,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start >= 200 AND bin.start < 1000, bin.density, 0)), SUM(bin.density)), 4) AS avg_ttfb,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start >= 1000, bin.density, 0)), SUM(bin.density)), 4) AS slow_ttfb
  FROM
    `chrome-ux-report.all.201907`,
    UNNEST(experimental.time_to_first_byte.histogram.bin) AS bin
  GROUP BY
    origin,
    speed
)
GROUP BY
  speed
ORDER BY
  pct_fast_ttfb DESC
