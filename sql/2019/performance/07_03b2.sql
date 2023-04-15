#standardSQL
# 07_03b2: % fast FCP per (new) PSI by device
SELECT
  device,
  ROUND(COUNTIF(fast_fcp >= .75) * 100 / COUNT(0), 2) AS pct_fast_fcp,
  ROUND(COUNTIF(NOT (slow_fcp >= .25) AND NOT (fast_fcp >= .75)) * 100 / COUNT(0), 2) AS pct_avg_fcp,
  ROUND(COUNTIF(slow_fcp >= .25) * 100 / COUNT(0), 2) AS pct_slow_fcp
FROM (
  SELECT
    form_factor.name AS device,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start < 1000, bin.density, 0)), SUM(bin.density)), 4) AS fast_fcp,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start >= 1000 AND bin.start < 3000, bin.density, 0)), SUM(bin.density)), 4) AS avg_fcp,
    ROUND(SAFE_DIVIDE(SUM(IF(bin.start >= 3000, bin.density, 0)), SUM(bin.density)), 4) AS slow_fcp
  FROM
    `chrome-ux-report.all.201807`,
    UNNEST(first_contentful_paint.histogram.bin) AS bin
  GROUP BY
    origin,
    device
)
GROUP BY
  device
ORDER BY
  pct_fast_fcp DESC
