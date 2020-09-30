#standardSQL
#web_font_usage_breakdown_with_fcp
SELECT
  client,
  NET.HOST(url) AS host,
  COUNT(0) AS freq_host,
  SUM(COUNT(0)) OVER(PARTITION BY client) AS TOTAL,
  COUNT(0) * 100 / SUM(COUNT(0)) OVER(PARTITION BY client) AS pct_host,
  COUNTIF(fast_fcp>=0.75) * 100 / COUNT(0) AS pct_good_fcp,
  COUNTIF(NOT(slow_fcp >= 0.25)
      AND NOT(fast_fcp >= 0.75)) * 100 / COUNT(0) AS pct_ni_fcp,
  COUNTIF(slow_fcp>=0.25) * 100 / COUNT(0) AS pct_poor_fcp,
FROM
  `httparchive.almanac.requests`
JOIN (
  SELECT DISTINCT
    origin, 
    device,
    fast_fcp,
    slow_fcp,
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date='2020-08-01')
ON
  CONCAT(origin, '/')=page AND
  IF(device='desktop','desktop','mobile')=client 
WHERE
  type = 'font'
  AND NET.HOST(url) != NET.HOST(page)
  AND date='2020-08-01'
GROUP BY
  client,
  host
ORDER BY
  freq_host DESC
