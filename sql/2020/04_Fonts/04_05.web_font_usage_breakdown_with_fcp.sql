#standardSQL
#web_font_usage_breakdown_with_fcp 
SELECT
 client,
 NET.HOST(url) AS host,
 COUNT(0) AS freq_host,
 SUM(COUNT(0)) OVER (PARTITION BY client ) AS TOTAL,
 ROUND(COUNT(0) * 100 / (COUNT(net.host(url))), 2) AS pct_host,
 round(countif(fast_fcp>=0.75)*100/count(0),0) as pct_fast_fcp,
 round(countif(NOT(slow_fcp >=0.25) AND NOT(fast_fcp>=0.75))*100/count(0),0) as pct_avg_fcp,
 round(countif(slow_fcp>=0.25)*100/count(0),0) as pct_slow_fcp,
FROM 
 `httparchive.almanac.requests`
JOIN 
 (select origin, fast_fcp, slow_fcp,
FROM 
 `chrome-ux-report.materialized.device_summary` where yyyymm=202007)
ON 
 concat(origin, '/')=page
WHERE 
 type = 'font' AND NET.HOST(url) != NET.HOST(page)
 AND date='2020-08-01'
GROUP BY
 client,
 host
ORDER BY
 freq_host  DESC