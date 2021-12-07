# 08_43: HTTP vs HTTPS
SELECT
  client,
  COUNTIF(STARTS_WITH(url, 'https://')) AS https,
  COUNTIF(STARTS_WITH(url, 'http://')) AS http,
  ROUND((COUNTIF(STARTS_WITH(url, 'https://')) / COUNT(0)) * 100, 2) AS pct_https,
  ROUND((COUNTIF(STARTS_WITH(url, 'http://')) / COUNT(0)) * 100, 2) AS pct_http
FROM
  `httparchive.almanac.summary_requests`
WHERE
  date = '2019-07-01'
GROUP BY
  client
