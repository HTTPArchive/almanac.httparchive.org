#standardSQL
# Section: ?
# Question: How prevalent are headers leaking server information? (count by number of hosts)
SELECT
  date,
  client,
  headername,
  COUNT(DISTINCT host) AS total_hosts,
  COUNT(DISTINCT IF(LOWER(response_header.name) = LOWER(headername), host, NULL)) AS count_with_header,
  COUNT(DISTINCT IF(LOWER(response_header.name) = LOWER(headername), host, NULL)) / COUNT(DISTINCT host) AS pct_with_header
FROM (
  SELECT
    date,
    client,
    NET.HOST(url) AS host,
    response_header
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_header
  WHERE
    (date = '2022-06-09' OR date = '2023-06-01' OR date = '2024-06-01') AND
    is_root_page
),
  UNNEST(['Server', 'X-Server', 'X-Backend-Server', 'X-Powered-By', 'X-Aspnet-Version']) AS headername
GROUP BY
  date,
  client,
  headername
ORDER BY
  date,
  client,
  count_with_header DESC
