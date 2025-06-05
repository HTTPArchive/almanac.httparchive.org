#standardSQL
# Section: Attack Preventions - Preventing attacks using Cross-Origin policies
# Question: Which are the most common COEP values?
# Note: Considers headers of main document responses only
SELECT
  client,
  coep_header,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_coep_headers,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS host,
    response_headers.value AS coep_header
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document AND
    LOWER(response_headers.name) = 'cross-origin-embedder-policy'
)
GROUP BY
  client,
  coep_header
ORDER BY
  pct DESC
LIMIT
  100
