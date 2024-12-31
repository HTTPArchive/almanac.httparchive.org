# Most common values for Referrer-Policy (at site level)

WITH totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE
  GROUP BY client
),

referrer_policy_custom_metrics AS (
  SELECT
    client,
    page,
    LOWER(TRIM(policy_meta)) AS policy_meta
  FROM `httparchive.all.pages`,
    UNNEST(SPLIT(JSON_VALUE(custom_metrics, '$.privacy.referrerPolicy.entire_document_policy'), ',')) AS policy_meta
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE
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
    TRIM(policy_header) AS policy_header
  FROM response_headers,
    UNNEST(SPLIT(value, ',')) AS policy_header
  WHERE
    name = 'referrer-policy'
)

SELECT
  client,
  COALESCE(policy_header, policy_meta) AS policy,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM referrer_policy_custom_metrics
FULL OUTER JOIN referrer_policy_headers
USING (client, page)
JOIN totals
USING (client)
GROUP BY
  client,
  policy
ORDER BY
  pct_pages DESC
LIMIT 100
