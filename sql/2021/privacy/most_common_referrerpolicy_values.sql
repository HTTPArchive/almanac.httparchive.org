#standardSQL
# Most common values for Referrer-Policy (at site level)

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_websites
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    client
),

referrer_policy_custom_metrics AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_VALUE(JSON_VALUE(payload, "$._privacy"), "$.referrerPolicy.entire_document_policy") AS entire_document_policy_meta
  FROM
    `httparchive.pages.2021_07_01_*`
),

response_headers AS (
  SELECT
    client,
    page,
    LOWER(JSON_VALUE(response_header, '$.name')) AS name,
    LOWER(JSON_VALUE(response_header, '$.value')) AS value
  FROM
    `httparchive.almanac.requests`,
    UNNEST(JSON_QUERY_ARRAY(response_headers)) response_header
  WHERE
    date = '2021-07-01' AND
    firstHtml = TRUE
),

referrer_policy_headers AS (
  SELECT
    client,
    page AS url,
    value AS entire_document_policy_header
  FROM
    response_headers
  WHERE
    name = 'referrer-policy'
)

SELECT
  client,
  COALESCE(entire_document_policy_header, entire_document_policy_meta) AS entire_document_policy,
  COUNT(0) AS number_of_websites_with_values,
  total_websites,
  COUNT(0) / total_websites AS pct_websites_with_values
FROM
  referrer_policy_custom_metrics
FULL OUTER JOIN
  referrer_policy_headers
USING (client, url)
JOIN
  totals
USING (client)
GROUP BY
  client,
  entire_document_policy,
  total_websites
ORDER BY
  client,
  number_of_websites_with_values DESC
