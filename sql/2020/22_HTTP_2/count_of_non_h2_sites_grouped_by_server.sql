# standardSQL
# Count of non-HTTP/2 Sites Grouped By Server
SELECT
  client,
  # Omit server version
  NORMALIZE_AND_CASEFOLD(REGEXP_EXTRACT(resp_server, r'\s*([^/]*)\s*')) AS server_header,
  COUNT(0) AS num_pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client), 4) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01' AND
  firstHtml AND
  JSON_EXTRACT_SCALAR(payload, '$._protocol') != 'HTTP/2'
GROUP BY
  client,
  server_header
HAVING
  num_pages >= 100
ORDER BY
  num_pages DESC
