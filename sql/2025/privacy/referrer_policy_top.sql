-- noqa: disable=PRS
-- Most common values for Referrer-Policy (at site level)

WITH base_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01' --AND rank = 1000
  GROUP BY client
),

referrer_policy_custom_metrics AS (
  SELECT
    client,
    root_page,
    LOWER(TRIM(policy_meta)) AS policy_meta
  FROM `httparchive.crawl.pages`,
    UNNEST(SPLIT(SAFE.STRING(custom_metrics.privacy.referrerPolicy.entire_document_policy), ',')) AS policy_meta
  WHERE date = '2025-07-01' --AND rank = 1000
),

response_headers AS (
  SELECT
    client,
    root_page,
    LOWER(response_header.name) AS name,
    LOWER(response_header.value) AS value
  FROM `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_header
  WHERE
    date = '2025-07-01' AND
    is_main_document = TRUE
    --AND rank = 1000
),

referrer_policy_headers AS (
  SELECT
    client,
    root_page,
    TRIM(policy_header) AS policy_header
  FROM response_headers,
    UNNEST(SPLIT(value, ',')) AS policy_header
  WHERE name = 'referrer-policy'
)

FROM referrer_policy_custom_metrics
|> FULL OUTER JOIN referrer_policy_headers USING (client, root_page)
|> EXTEND COALESCE(policy_header, policy_meta) AS policy
|> AGGREGATE COUNT(DISTINCT root_page) AS number_of_websites GROUP BY client, policy
|> JOIN base_totals USING (client)
|> EXTEND number_of_websites / total_websites AS pct_websites
|> DROP total_websites
|> PIVOT(
  ANY_VALUE(number_of_websites) AS websites_count,
  ANY_VALUE(pct_websites) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS Mobile, pct_desktop AS Desktop
|> ORDER BY COALESCE(websites_count_desktop, 0) + COALESCE(websites_count_mobile, 0) DESC
