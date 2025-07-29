#standardSQL
# Section: Attack Preventions - Security Header Adoptions?
# Question: Which are the most common OAC values?
# Note: Considers headers of all main document responses
SELECT
  client,
  oac_header,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_oac_headers,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS host,
    response_headers.value AS oac_header
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    is_main_document AND
    LOWER(response_headers.name) = 'origin-agent-cluster'
)
GROUP BY
  client,
  oac_header
ORDER BY
  pct DESC
LIMIT
  100
