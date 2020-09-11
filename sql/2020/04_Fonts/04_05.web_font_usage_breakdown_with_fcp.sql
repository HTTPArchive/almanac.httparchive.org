#standardSQL
#web_font_usage_breakdown_with_fcp
SELECT
  client,
  NET.HOST(url) AS host,
  COUNT(0) AS freq_host,
  SUM(COUNT(0)) OVER(PARTITION BY client) AS TOTAL,
  ROUND(COUNT(0)*100/SUM(COUNT(0)) OVER(PARTITION BY client), 2) AS pct_host,
  ROUND(COUNTIF(fast_fcp>=0.75)*100/COUNT(0),0) AS pct_fast_fcp,
  ROUND(COUNTIF(NOT(slow_fcp >=0.25)
      AND NOT(fast_fcp>=0.75))*100/COUNT(0),0) AS pct_moderate_fcp,
  ROUND(COUNTIF(slow_fcp>=0.25)*100/COUNT(0),0) AS pct_slow_fcp,
FROM
  `httparchive.almanac.requests`
JOIN (
  SELECT
    origin,
    fast_fcp,
    slow_fcp,
  FROM
    `chrome-ux-report.materialized.metrics_summary`
  WHERE
    yyyymm=202008)
ON
  CONCAT(origin, '/')=page
WHERE
  type = 'font'
  AND NET.HOST(url) != NET.HOST(page)
  AND date='2020-08-01'
GROUP BY
  client,
  host
ORDER BY
  freq_host DESC
