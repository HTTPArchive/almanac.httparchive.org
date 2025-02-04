#standardSQL
# Section: Attack Preventions - Security Header Adoptions?
# Question: Which are the most common TAO values?
# Note: Considers headers of all responses including all subresources (header is used for script and img resources)
SELECT
  client,
  tao_header,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_tao_headers,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS host,
    response_headers.value AS tao_header
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    LOWER(response_headers.name) = 'timing-allow-origin'
)
GROUP BY
  client,
  tao_header
ORDER BY
  pct DESC
LIMIT
  100
