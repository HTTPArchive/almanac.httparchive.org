#standardSQL
#local_vs_host_with_fcp
SELECT
  client,
  CASE 
    WHEN NET.HOST(page) != NET.HOST(url) THEN "host"     
    ELSE "local"
  END as host_local,
  COUNT(0) AS freq_req,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_req,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_req,
  COUNTIF(fast_fcp >= 0.75) / COUNT(0) AS pct_good_fcp_req,
  COUNTIF(NOT(slow_fcp >= 0.25)
      AND NOT(fast_fcp >= 0.75)) / COUNT(0) AS pct_ni_fcp_req,
  COUNTIF(slow_fcp >= 0.25) / COUNT(0) AS pct_poor_fcp_req, 
  COUNT(DISTINCT page) as freq_page,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total_page,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_page,
  COUNT(DISTINCT IF(fast_fcp >= 0.75, page, NULL)) / COUNT(DISTINCT page) AS pct_good_fcp_page,
  COUNT(DISTINCT IF(NOT(slow_fcp >= 0.25) AND NOT(fast_fcp >= 0.75), page, null))  / COUNT(DISTINCT page) AS pct_ni_fcp_page,
  COUNT(DISTINCT IF(slow_fcp >= 0.25, page, null)) / COUNT(DISTINCT page) AS pct_poor_fcp_page,
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
  IF(device = 'desktop', 'desktop', 'mobile')=client        
WHERE
  type = 'font'
  AND date='2020-08-01'
GROUP BY
  client,
  host_local
ORDER BY
  client, host_local, freq_req DESC