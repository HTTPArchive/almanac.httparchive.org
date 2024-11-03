# standardSQL
# Count of H2 and H3 Sites Grouped By Server
# Note this is a percentage of usage of that server not the total crawl
# I.e. Do Apache servers tend to be on latest features or lagging? What about compared to Nginx?
# Does that indicate server software is not upgrade as often (tied to OS?) or defaults are old?
SELECT
  client,
  server_header,
  http_version_category,
  http_version,
  COUNT(0) AS num_pages,
  SUM(COUNT(0)) OVER (PARTITION BY client, server_header) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, server_header) AS pct
FROM (
  SELECT
    client,
    CASE
      WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/2+'
      WHEN LOWER(protocol) = 'http/2' OR LOWER(protocol) = 'http/3' THEN 'HTTP/2+'
      WHEN protocol IS NULL THEN 'Unknown'
      ELSE UPPER(protocol)
    END AS http_version_category,
    CASE
      WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/3'
      WHEN protocol IS NULL THEN 'Unknown'
      ELSE UPPER(protocol)
    END AS http_version,
    -- Omit server version
    NORMALIZE_AND_CASEFOLD(REGEXP_EXTRACT(resp_server, r'\s*([^/]*)\s*')) AS server_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHTML
)
GROUP BY
  client,
  server_header,
  http_version_category,
  http_version
QUALIFY
  total >= 1000
ORDER BY
  num_pages DESC,
  client,
  server_header
