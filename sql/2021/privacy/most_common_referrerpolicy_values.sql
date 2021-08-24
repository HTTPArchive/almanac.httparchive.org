#standardSQL
# Most common values for Referrer-Policy (at site level)

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
),

total_nb_pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_nb_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    1
),

referrer_policy_custom_metrics AS (
  SELECT
    client,
    url,
    JSON_VALUE(metrics, "$.referrerPolicy.entire_document_policy") AS entire_document_policy_meta
   FROM
    pages_privacy
),

response_headers AS (
  SELECT
    client,
    page,
    JSON_VALUE(response_header, '$.name') AS name,
    JSON_VALUE(response_header, '$.value') AS value
  FROM
    `httparchive.almanac.summary_response_bodies`,
    UNNEST(JSON_QUERY_ARRAY(response_headers)) response_header
  WHERE
    date = '2021-07-01'
  AND
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
    name = 'Referrer-Policy'
)

SELECT
  client,
  COALESCE(entire_document_policy_header, entire_document_policy_meta) AS entire_document_policy,
  COUNT(0) AS nb_websites_with_values,
  ROUND(COUNT(0) / MIN(total_nb_pages.total_nb_pages), 2) AS pct_websites_with_values
FROM
  referrer_policy_custom_metrics FULL OUTER JOIN referrer_policy_headers USING (client, url)
  JOIN total_nb_pages USING (client)
GROUP BY
  1, 2
