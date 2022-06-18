SELECT
  client,
  resp_content_encoding AS content_encoding,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  firstHtml
GROUP BY
  client,
  content_encoding
ORDER BY
  pct DESC
