WITH referrer_policy_custom_metrics AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics, '$.privacy.referrerPolicy.entire_document_policy') AS meta_policy,
    ARRAY_LENGTH(JSON_QUERY_ARRAY(custom_metrics, '$.privacy.referrerPolicy.individual_requests')) > 0 AS individual_requests,
    CAST(JSON_VALUE(custom_metrics, '$.privacy.referrerPolicy.link_relations.A') AS INT64) > 0 AS link_relations
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
    LOWER(response_header.value) AS header_policy
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
        meta_policy IS NOT NULL,
        page, NULL)) AS number_of_pages_with_entire_document_policy_meta,
    COUNT(DISTINCT IF(
        header_policy IS NOT NULL,
        page, NULL)) AS number_of_pages_with_entire_document_policy_header,
    COUNT(DISTINCT IF(
      meta_policy IS NOT NULL OR
      header_policy IS NOT NULL,
      page, NULL)
    ) AS number_of_pages_with_entire_document_policy,
    COUNT(DISTINCT IF(
        individual_requests,
        page, NULL)) AS number_of_pages_with_any_individual_requests,
    COUNT(DISTINCT IF(
        link_relations,
        page, NULL)) AS number_of_pages_with_any_link_relations,
    COUNT(DISTINCT IF(
      meta_policy IS NOT NULL OR
      header_policy IS NOT NULL OR
      individual_requests OR
      link_relations,
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
