#standardSQL
# Prevalence of values for Server and X-Powered-By headers; count by number of hosts.

SELECT
  server.client,
  resp_server,
  total_server_headers,
  freq_server,
  pct_server,
  server.n,
  powered.client,
  resp_x_powered_by,
  total_powered_headers,
  freq_powered,
  pct_powered
FROM
(
  SELECT
    ROW_NUMBER() OVER (ORDER BY COUNT(DISTINCT NET.HOST(page)) DESC) AS n,
    client,
    resp_server,
    SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS total_server_headers,
    COUNT(DISTINCT NET.HOST(page)) AS freq_server,
    COUNT(DISTINCT NET.HOST(page)) / SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS pct_server
  FROM
    `httparchive.almanac.requests`
  WHERE
    (date = "2020-07-01" OR date = "2021-07-01") AND
    resp_server IS NOT NULL AND
    resp_server <> ''
  GROUP BY
    client,
    resp_server
  ) AS server
INNER JOIN
  (
  SELECT
    ROW_NUMBER() OVER (ORDER BY COUNT(DISTINCT NET.HOST(page)) DESC) AS n,
    client,
    resp_x_powered_by,
    SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS total_powered_headers,
    COUNT(DISTINCT NET.HOST(page)) AS freq_powered,
    COUNT(DISTINCT NET.HOST(page)) / SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS pct_powered
  FROM
    `httparchive.almanac.requests`
  WHERE
    (date = "2020-07-01" OR date = "2021-07-01") AND
    resp_x_powered_by IS NOT NULL AND
    resp_x_powered_by <> ''
  GROUP BY
    client,
    resp_x_powered_by
  ) AS powered ON server.n = powered.n
  ORDER BY n
  LIMIT 40
