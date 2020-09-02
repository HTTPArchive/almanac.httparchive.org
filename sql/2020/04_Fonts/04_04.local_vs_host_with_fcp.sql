#standardSQL
#local_vs_host_with_fcp 
SELECT
 client,
 COUNTIF(NET.HOST(page) != NET.HOST(url)) AS host,
 COUNTIF(NET.HOST(page) = NET.HOST(url)) AS local,
 COUNT(0) AS total,
 ROUND(COUNTIF(NET.HOST(page) != NET.HOST(url)) * 100 / COUNT(0), 2) AS pct_host,
 ROUND(COUNTIF(NET.HOST(page) = NET.HOST(url)) * 100 / COUNT(0), 2) AS pct_local,
 ROUND(countif(fast_fcp>=0.75)*100/count(0),0) as pct_fast_fcp,
 ROUND(countif(NOT(slow_fcp >=0.25) AND NOT(fast_fcp>=0.75))*100/count(0),0) as pct_moderate_fcp,
 ROUND(countif(slow_fcp>=0.25)*100/count(0),0) as pct_slow_fcp,
FROM 
 `httparchive.almanac.requests`
JOIN 
 (select origin, fast_fcp, slow_fcp,
FROM 
 `chrome-ux-report.materialized.device_summary` where yyyymm=202007)
ON 
 concat(origin, '/')=page
WHERE 
 type = 'font'
GROUP BY 
 client
