#standardSQL
# Section: Attack Preventions - Preventing attacks using Cross-Origin policies
# Question: Which are the most common CORP values?
# Note: Considers headers of all responses including all subresources (header is used for script and img resources)
SELECT
  client,
  corp_header,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_corp_headers,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS host,
    response_headers.value AS corp_header
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    LOWER(response_headers.name) = 'cross-origin-resource-policy'
)
GROUP BY
  client,
  corp_header
ORDER BY
  pct DESC
LIMIT
  100
