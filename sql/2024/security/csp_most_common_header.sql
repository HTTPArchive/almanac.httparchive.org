#standardSQL
# Section: Attack Preventions - Preventing attacks using CSP
# Question: Which are the most common CSP values on home pages?
# Note: Only considers CSPs of the home page and not of embedded resources
SELECT
  client,
  csp_header,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_csp_headers,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    response_headers.value AS csp_header
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document AND
    LOWER(response_headers.name) = 'content-security-policy')
WHERE
  csp_header IS NOT NULL
GROUP BY
  client,
  csp_header
ORDER BY
  pct DESC
LIMIT
  100
