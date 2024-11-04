#standardSQL
# Section: ? (Permissions)
# Question: Which are the most common PP values?
# Note: Considers headers of main document responses
SELECT
  client,
  pp_header,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_pp_headers,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS host,
    response_headers.value AS pp_header
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document AND
    LOWER(response_headers.name) = 'permissions-policy')
GROUP BY
  client,
  pp_header
ORDER BY
  pct DESC
LIMIT
  100
