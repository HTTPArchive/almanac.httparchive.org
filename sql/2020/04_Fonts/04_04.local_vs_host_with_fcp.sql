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
  COUNT(0)*100/SUM(COUNT(0)) OVER (PARTITION BY client) AS pct,
  COUNTIF(fast_fcp >= 0.75)*100/COUNT(0) AS pct_good_fcp,
  COUNTIF(NOT(slow_fcp >= 0.25)
      AND NOT(fast_fcp >= 0.75))*100/COUNT(0) AS pct_ni_fcp,
  COUNTIF(slow_fcp >= 0.25)*100/COUNT(0) AS pct_poor_fcp,      
FROM 
    `httparchive.almanac.requests`
JOIN (
  SELECT DISTINCT
    origin, device,
    fast_fcp,
    slow_fcp,
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm=202008)
ON
  CONCAT(origin, '/')=page AND
  IF(device='desktop','desktop','mobile')=client        
WHERE
  type = 'font'
  AND date='2020-08-01'
GROUP BY
  client,
  host_local
ORDER BY
  client, host_local, freq DESC
