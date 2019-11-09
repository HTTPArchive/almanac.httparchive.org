# 08_43: HTTP vs HTTPS
SELECT
  client,
  SUM(IF(url LIKE 'https://%', 1, 0))  AS https,
  SUM(IF(url LIKE 'http://%', 1, 0))  AS http,
  ROUND((SUM(IF(url LIKE 'https://%', 1, 0)) / COUNT(*))*100,2) AS pct_https,
  ROUND((SUM(IF(url LIKE 'http://%', 1, 0)) / COUNT(*))*100,2) AS pct_http
FROM
  `httparchive.almanac.requests` 
GROUP BY
  client
