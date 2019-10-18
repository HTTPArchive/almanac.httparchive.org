#standardSQL
# 10_17: HTTP(S) adoption
SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(STARTS_WITH(url, 'https')) AS https,
  COUNTIF(STARTS_WITH(url, 'http:')) AS http,
  COUNT(0) AS total,
  ROUND(COUNTIF(STARTS_WITH(url, 'https')) * 100 / COUNT(0), 2) AS pct_https,
  ROUND(COUNTIF(STARTS_WITH(url, 'http:')) * 100 / COUNT(0), 2) AS pct_http
FROM
  `httparchive.summary_pages.2019_07_01_*`
GROUP BY
  client
