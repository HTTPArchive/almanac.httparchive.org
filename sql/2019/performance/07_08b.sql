#standardSQL
# 07_08b: % fast TTFB by device
SELECT
  device,
  ROUND(COUNTIF(fast_ttfb >= .9) * 100 / COUNT(0), 2) AS pct_fast_ttfb,
  ROUND(COUNTIF(NOT (slow_ttfb >= .1) AND NOT (fast_ttfb >= .9)) * 100 / COUNT(0), 2) AS pct_avg_ttfb,
  ROUND(COUNTIF(slow_ttfb >= .1) * 100 / COUNT(0), 2) AS pct_slow_ttfb
FROM (
  SELECT
    device,
    SAFE_DIVIDE(fast_ttfb, fast_ttfb + avg_ttfb + slow_ttfb) AS fast_ttfb,
    SAFE_DIVIDE(avg_ttfb, fast_ttfb + avg_ttfb + slow_ttfb) AS avg_ttfb,
    SAFE_DIVIDE(slow_ttfb, fast_ttfb + avg_ttfb + slow_ttfb) AS slow_ttfb
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm = '201907' AND
    fast_ttfb + avg_ttfb + slow_ttfb > 0 AND
    device IN ('desktop', 'phone')
)
GROUP BY
  device
