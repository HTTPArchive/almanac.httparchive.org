SELECT
  resp_content_type,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND((COUNT(0) * 100 / total), 2) AS pct,
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client
ORDER BY
  client DESC
