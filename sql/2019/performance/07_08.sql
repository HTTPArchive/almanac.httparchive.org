#standardSQL
# 07_08: % fast TTFB using FCP-like thresholds
SELECT
  ROUND(COUNTIF(fast_ttfb >= .75) * 100 / COUNT(0), 2) AS pct_fast_ttfb,
  ROUND(COUNTIF(NOT (slow_ttfb >= .25) AND NOT (fast_ttfb >= .75)) * 100 / COUNT(0), 2) AS pct_avg_ttfb,
  ROUND(COUNTIF(slow_ttfb >= .25) * 100 / COUNT(0), 2) AS pct_slow_ttfb
FROM
  `chrome-ux-report.materialized.metrics_summary`
WHERE
  date = '2019-07-01' AND
  fast_ttfb + avg_ttfb + slow_ttfb > 0
