#standardSQL
# Websites using Referrer-Policy

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
),

referrer_policy_custom_metrics AS (
  SELECT
    client,
    url,
    JSON_VALUE(metrics, "$.referrerPolicy.entire_document_policy") AS entire_document_policy_meta,
    JSON_QUERY_ARRAY(metrics, "$.referrerPolicy.individual_requests") AS individual_requests,
    JSON_QUERY_ARRAY(metrics, "$.referrerPolicy.link_relations") AS link_relations
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
  *,
  ROUND(nb_websites_with_entire_document_policy_meta / nb_websites, 2) AS pct_websites_with_entire_document_policy_meta,
  ROUND(nb_websites_with_entire_document_policy_header / nb_websites, 2) AS pct_websites_with_entire_document_policy_header,
  ROUND(nb_websites_with_entire_document_policy / nb_websites, 2) AS pct_websites_with_entire_document_policy,
  ROUND(nb_websites_with_any_individual_requests / nb_websites, 2) AS pct_websites_with_any_individual_requests,
  ROUND(nb_websites_with_any_link_relations / nb_websites, 2) AS pct_websites_with_any_link_relations,
  ROUND(nb_websites_with_any_referrer_policy / nb_websites, 2) AS pct_websites_with_any_referrer_policy
FROM (
  SELECT
    client,
    COUNTIF(entire_document_policy_meta IS NOT NULL) AS nb_websites_with_entire_document_policy_meta,
    COUNTIF(entire_document_policy_header IS NOT NULL) AS nb_websites_with_entire_document_policy_header,
    COUNTIF(
      entire_document_policy_meta IS NOT NULL OR entire_document_policy_header IS NOT NULL
    ) AS nb_websites_with_entire_document_policy,
    COUNTIF(ARRAY_LENGTH(individual_requests) > 0) AS nb_websites_with_any_individual_requests,
    COUNTIF(ARRAY_LENGTH(link_relations) > 0) AS nb_websites_with_any_link_relations,
    COUNTIF(
      entire_document_policy_meta IS NOT NULL OR entire_document_policy_header IS NOT NULL OR
      ARRAY_LENGTH(individual_requests) > 0 OR ARRAY_LENGTH(link_relations) > 0
    ) AS nb_websites_with_any_referrer_policy,
    COUNT(0) AS nb_websites
  FROM
    referrer_policy_custom_metrics FULL OUTER JOIN referrer_policy_headers USING (client, url)
  GROUP BY
    1
)
