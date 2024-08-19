#standardSQL
# Section: Attack preventions - Preventing attacks using CSP
# Question: Which are the most common "allowed host" values in CSPs on home pages?
WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document
  GROUP BY
    client
)

SELECT
  client,
  csp_allowed_host,
  total AS total_pages,
  COUNT(DISTINCT page) AS freq,
  COUNT(DISTINCT page) / total AS pct
FROM (
  SELECT
    client,
    page,
    response_headers.value AS csp_header
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document AND
    LOWER(response_headers.name) = 'content-security-policy'
)
JOIN
  totals
USING (client),
  UNNEST(REGEXP_EXTRACT_ALL(csp_header, r'(?i)(https*://[^\s;]+)[\s;]')) AS csp_allowed_host
WHERE
  csp_header IS NOT NULL
GROUP BY
  client,
  total,
  csp_allowed_host
ORDER BY
  pct DESC
LIMIT 100
