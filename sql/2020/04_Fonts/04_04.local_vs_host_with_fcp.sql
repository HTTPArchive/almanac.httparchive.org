#standardSQL
#local_vs_host_with_fcp
SELECT
  client,
  CASE 
    WHEN NET.HOST(page) != NET.HOST(url) THEN "host"     
    ELSE "local"
  END as host_local,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0)*100/SUM(COUNT(0)) OVER (PARTITION BY client),2) AS pct,
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
  AND date='2020-08-01'
GROUP BY
  client,
  host_local
ORDER BY
  client, host_local, freq DESC