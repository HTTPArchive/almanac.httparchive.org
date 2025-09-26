# Query for compression methods for wasm

SELECT
  client,
  compression,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(0) AS wasm_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_wasm_requests,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_wasm_requests
FROM (
  SELECT
    client,
    page,
    response_headers.value AS compression
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2025-07-01' AND
    type = 'wasm' AND
    LOWER(response_headers.name) = 'content-encoding'
)
JOIN (
  SELECT
    client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  compression
ORDER BY
  pct_wasm_requests DESC