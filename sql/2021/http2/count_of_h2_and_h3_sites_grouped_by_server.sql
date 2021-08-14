# standardSQL
# Count of H2 and H3 Sites Grouped By Server
SELECT
  client,
  protocol AS http_version,
  # Omit server version
  NORMALIZE_AND_CASEFOLD(REGEXP_EXTRACT(resp_server, r'\s*([^/]*)\s*')) AS server_header,
  COUNT(0) AS num_pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client), 4) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01' AND
  firstHtml AND
  (LOWER(protocol) = "http/2" OR
    LOWER(protocol) LIKE "%quic%" OR
    LOWER(protocol) LIKE "h3%" OR
    LOWER(protocol) = "http/3"
  )
GROUP BY
  client,
  http_version,
  server_header
HAVING
  num_pages >= 100
ORDER BY
  num_pages DESC
