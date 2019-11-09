# 08_43: HTTP vs HTTPS
SELECT
  client,
  COUNTIF(STARTS_WITH(url, 'https://'))  AS https,
  COUNTIF(STARTS_WITH(url, 'http://'))  AS http,
  ROUND((COUNTIF(STARTS_WITH(url, 'https://')) / COUNT(*))*100,2) AS pct_https,
  ROUND((COUNTIF(STARTS_WITH(url, 'http://')) / COUNT(*))*100,2) AS pct_http
FROM
  `httparchive.almanac.summary_requests`  
GROUP BY
  client
