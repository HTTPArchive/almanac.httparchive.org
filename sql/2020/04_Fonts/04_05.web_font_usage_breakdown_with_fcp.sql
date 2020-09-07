#standardSQL
#web_font_usage_breakdown_with_fcp(??urlNotGroup)
SELECT
  client,
  NET.HOST(url) AS host,
  COUNT(0) AS freq_host,
  SUM(COUNT(0)) OVER(PARTITION BY client) AS TOTAL,
  ROUND(COUNT(0) * 100 / (COUNT(net.host(url))), 2) AS pct_host,
  fast,
  avg,
  slow
FROM
  `httparchive.almanac.requests`
JOIN (
  SELECT
    origin,
    ROUND(fast_fcp * 100, 2) AS fast,
    ROUND(avg_fcp * 100, 2) AS avg,
    ROUND(slow_fcp * 100, 2) AS slow,
  FROM
    `chrome-ux-report.materialized.metrics_summary`
  WHERE
    yyyymm=202008
    AND fast_fid + avg_fid + slow_fid > 0
  ORDER BY
    fast DESC )
ON
  CONCAT(origin, '/')=page
WHERE
  type = 'font'
  AND NET.HOST(url) != NET.HOST(page)
  AND date='2020-08-01'
GROUP BY
  client,
  host,
  fast,
  avg,
  slow
ORDER BY
  freq_host DESC