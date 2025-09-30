# Query to list out various compression methods used in wasm

SELECT
  client,
  compression_method,
  COUNT(0) AS wasm_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_wasm_requests_by_client,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS percentage
FROM (
  SELECT
    client,
    response_headers.value AS compression_method
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2025-07-01' AND
    type = 'wasm' AND
    LOWER(response_headers.name) = 'content-encoding'
)
GROUP BY
  client,
  compression_method
ORDER BY
  percentage DESC
