# standardSQL
# Adoption of HTTP/2 by site and requests
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
  protocol,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_req,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS num_requests_pct,
  COUNTIF(firstHTML) AS num_pages,
  SUM(COUNTIF(firstHTML)) OVER (PARTITION BY client) AS total_pages,
  COUNTIF(firstHTML) / SUM(COUNTIF(firstHTML)) OVER (PARTITION BY client) AS num_pages_pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client,
  protocol
ORDER BY
  client,
  num_requests_pct DESC
