# standardSQL
# Adoption of HTTP/2 by site and requests
SELECT
  client,
  firstHtml,
  JSON_EXTRACT_SCALAR(payload, '$._protocol') AS http_version,
  COUNT(0) AS num_requests,
  ROUND(COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client), 4) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01'
GROUP BY
  client,
  firstHtml,
  http_version
ORDER BY
  pct DESC
