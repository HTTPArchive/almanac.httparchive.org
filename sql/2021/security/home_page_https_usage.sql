#standardSQL
# Home page usage of HTTPS
SELECT
  client,
  STARTS_WITH(page, 'https') AS https,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01' AND
  firstHtml
GROUP BY
  client,
  https
