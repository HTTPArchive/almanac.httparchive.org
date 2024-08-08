#standardSQL
# Most common values for Referrer-Policy (at site level)

WITH totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    rank <= 10000
  GROUP BY client
),

referrer_policy_custom_metrics AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics, '$.privacy.referrerPolicy.entire_document_policy') AS entire_document_policy_meta
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    rank <= 10000
),

response_headers AS (
  SELECT
    client,
    page,
    LOWER(response_header.name) AS name,
    LOWER(response_header.value) AS value
  FROM `httparchive.all.requests`,
    UNNEST(response_headers) AS response_header
  WHERE
    date = '2024-06-01' AND
    is_main_document = TRUE
),

referrer_policy_headers AS (
  SELECT
    client,
    page,
    value AS entire_document_policy_header
  FROM response_headers
  WHERE
    name = 'referrer-policy'
)

SELECT
  client,
  COALESCE(entire_document_policy_header, entire_document_policy_meta) AS entire_document_policy,
  COUNT(DISTINCT page) AS pages_with_values,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages_with_values
FROM referrer_policy_custom_metrics
FULL OUTER JOIN referrer_policy_headers
USING (client, page)
JOIN totals
USING (client)
GROUP BY
  client,
  entire_document_policy
ORDER BY
  client,
  pages_with_values DESC
