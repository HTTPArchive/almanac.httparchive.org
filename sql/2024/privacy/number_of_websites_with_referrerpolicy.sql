WITH referrer_policy_custom_metrics AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics, '$.privacy.referrerPolicy.entire_document_policy') AS entire_document_policy_meta,
    JSON_QUERY_ARRAY(custom_metrics, '$.privacy.referrerPolicy.individual_requests') AS individual_requests,
    JSON_QUERY_ARRAY(custom_metrics, '$.privacy.referrerPolicy.link_relations') AS link_relations
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE
),
referrer_policy_headers AS (
  SELECT
    client,
    page,
    LOWER(response_header.value) AS entire_document_policy_header
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS response_header
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    is_main_document = TRUE AND
    response_header.name = 'referrer-policy'
)

SELECT
  client,
  number_of_pages_with_entire_document_policy_meta / number_of_pages AS pct_pages_with_entire_document_policy_meta,
  number_of_pages_with_entire_document_policy_meta,
  number_of_pages_with_entire_document_policy_header / number_of_pages AS pct_pages_with_entire_document_policy_header,
  number_of_pages_with_entire_document_policy_header,
  number_of_pages_with_entire_document_policy / number_of_pages AS pct_pages_with_entire_document_policy,
  number_of_pages_with_entire_document_policy,
  number_of_pages_with_any_individual_requests / number_of_pages AS pct_pages_with_any_individual_requests,
  number_of_pages_with_any_individual_requests,
  number_of_pages_with_any_link_relations / number_of_pages AS pct_pages_with_any_link_relations,
  number_of_pages_with_any_link_relations,
  number_of_pages_with_any_referrer_policy / number_of_pages AS pct_pages_with_any_referrer_policy,
  number_of_pages_with_any_referrer_policy
FROM (
  SELECT
    client,
    COUNT(DISTINCT page) AS number_of_pages,
    COUNT(DISTINCT IF(
        entire_document_policy_meta IS NOT NULL,
        page, NULL)) AS number_of_pages_with_entire_document_policy_meta,
    COUNT(DISTINCT IF(
        entire_document_policy_header IS NOT NULL,
        page, NULL)) AS number_of_pages_with_entire_document_policy_header,
    COUNT(DISTINCT IF(
      entire_document_policy_meta IS NOT NULL OR
      entire_document_policy_header IS NOT NULL,
      page, NULL)
    ) AS number_of_pages_with_entire_document_policy,
    COUNT(DISTINCT IF(
        ARRAY_LENGTH(individual_requests) > 0,
        page, NULL)) AS number_of_pages_with_any_individual_requests,
    COUNT(DISTINCT IF(
        ARRAY_LENGTH(link_relations) > 0,
        page, NULL)) AS number_of_pages_with_any_link_relations,
    COUNT(DISTINCT IF(
      entire_document_policy_meta IS NOT NULL OR
      entire_document_policy_header IS NOT NULL OR
      ARRAY_LENGTH(individual_requests) > 0 OR
      ARRAY_LENGTH(link_relations) > 0,
      page, NULL)
    ) AS number_of_pages_with_any_referrer_policy
  FROM
    referrer_policy_custom_metrics
  FULL OUTER JOIN
    referrer_policy_headers
  USING (client, page)
  GROUP BY client
)
ORDER BY
  client
