#standardSQL
# Question: Which are the most common document policy values on home pages?
# Note: Only considers document policies of the home page and not of embedded resources
# Note: There is no registry of possible directives, see https://github.com/WICG/document-policy/blob/main/integration.md
SELECT
  client,
  document_policy_header,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_document_policy_headers,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    response_headers.value AS document_policy_header
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    is_main_document AND
    LOWER(response_headers.name) = 'document-policy'
)
WHERE
  document_policy_header IS NOT NULL
GROUP BY
  client,
  document_policy_header
ORDER BY
  pct DESC
LIMIT
  100
