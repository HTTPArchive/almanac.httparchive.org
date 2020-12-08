#standardSQL
# Home page usage of HTTPS
SELECT
  client,
  STARTS_WITH(page, 'https') AS https,
  count(0) AS pages,
  sum(count(0)) OVER (PARTITION BY client) as total,
  count(0) / sum(count(0)) OVER (PARTITION BY client) as pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01' AND
  firstHtml = true
GROUP BY
  client,
  STARTS_WITH(page, 'https')
