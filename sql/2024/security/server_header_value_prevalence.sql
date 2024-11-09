#standardSQL
# Section: ?
# Question: Which are the most common Server and X-Powered-By headers? (count by number of hosts)
# Note: Different dates taken together; Is it correct to take the host of the page instead of the URL? Maybe only take is_main_document?
SELECT
  client,
  type,
  resp_value,
  total,
  freq,
  pct
FROM
  (
    SELECT
      client,
      'server' AS type,
      response_header.value AS resp_value,
      SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS total,
      COUNT(DISTINCT NET.HOST(page)) AS freq,
      COUNT(DISTINCT NET.HOST(page)) / SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS pct
    FROM
      `httparchive.all.requests`,
      UNNEST(response_headers) AS response_header
    WHERE
      (date = '2022-06-09' OR date = '2023-06-01' OR date = '2024-06-01') AND
      is_root_page AND
      LOWER(response_header.name) = 'server'
    GROUP BY
      client,
      type,
      resp_value
    ORDER BY
      freq DESC
    LIMIT 40
  )
UNION ALL
(
  SELECT
    client,
    'x-powered-by' AS type,
    response_header.value AS resp_value,
    SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS total,
    COUNT(DISTINCT NET.HOST(page)) AS freq,
    COUNT(DISTINCT NET.HOST(page)) / SUM(COUNT(DISTINCT NET.HOST(page))) OVER (PARTITION BY client) AS pct
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_header
  WHERE
    (date = '2022-06-09' OR date = '2023-06-01' OR date = '2024-06-01') AND
    is_root_page AND
    LOWER(response_header.name) = 'x-powered-by'
  GROUP BY
    client,
    type,
    resp_value
  ORDER BY
    freq DESC
  LIMIT 40
)
ORDER BY
  client,
  type,
  freq DESC
