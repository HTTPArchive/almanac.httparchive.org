# standardSQL
# Adoption of HTTP/2 by site and requests
SELECT
  client,
  firstHtml,
  protocol AS http_version,
  COUNT(0) AS num_requests,
  ROUND(COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client), 4) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client,
  firstHtml,
  http_version
ORDER BY
  pct DESC
