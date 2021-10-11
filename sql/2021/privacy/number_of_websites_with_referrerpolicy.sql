#standardSQL
# Websites using Referrer-Policy

WITH referrer_policy_custom_metrics AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_VALUE(JSON_VALUE(payload, "$._privacy"), "$.referrerPolicy.entire_document_policy") AS entire_document_policy_meta,
    JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._privacy"), "$.referrerPolicy.individual_requests") AS individual_requests,
    JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._privacy"), "$.referrerPolicy.link_relations") AS link_relations
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
  *,
  number_of_websites_with_entire_document_policy_meta / number_of_websites AS pct_websites_with_entire_document_policy_meta,
  number_of_websites_with_entire_document_policy_header / number_of_websites AS pct_websites_with_entire_document_policy_header,
  number_of_websites_with_entire_document_policy / number_of_websites AS pct_websites_with_entire_document_policy,
  number_of_websites_with_any_individual_requests / number_of_websites AS pct_websites_with_any_individual_requests,
  number_of_websites_with_any_link_relations / number_of_websites AS pct_websites_with_any_link_relations,
  number_of_websites_with_any_referrer_policy / number_of_websites AS pct_websites_with_any_referrer_policy
FROM (
  SELECT
    client,
    COUNTIF(entire_document_policy_meta IS NOT NULL) AS number_of_websites_with_entire_document_policy_meta,
    COUNTIF(entire_document_policy_header IS NOT NULL) AS number_of_websites_with_entire_document_policy_header,
    COUNTIF(
      entire_document_policy_meta IS NOT NULL OR
      entire_document_policy_header IS NOT NULL
    ) AS number_of_websites_with_entire_document_policy,
    COUNTIF(ARRAY_LENGTH(individual_requests) > 0) AS number_of_websites_with_any_individual_requests,
    COUNTIF(ARRAY_LENGTH(link_relations) > 0) AS number_of_websites_with_any_link_relations,
    COUNTIF(
      entire_document_policy_meta IS NOT NULL OR
      entire_document_policy_header IS NOT NULL OR
      ARRAY_LENGTH(individual_requests) > 0 OR
      ARRAY_LENGTH(link_relations) > 0
    ) AS number_of_websites_with_any_referrer_policy,
    COUNT(0) AS number_of_websites
  FROM
    referrer_policy_custom_metrics
  FULL OUTER JOIN
    referrer_policy_headers
  USING (client, url)
  GROUP BY
    client
)
ORDER BY
  client
