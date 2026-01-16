-- noqa: disable=PRS

WITH referrer_policy_custom_metrics AS (
  SELECT
    client,
    root_page,
    SAFE.STRING(custom_metrics.privacy.referrerPolicy.entire_document_policy) AS meta_policy,
    ARRAY_LENGTH(JSON_QUERY_ARRAY(custom_metrics.privacy.referrerPolicy.individual_requests)) > 0 AS individual_requests,
    SAFE.INT64(custom_metrics.privacy.referrerPolicy.link_relations.A) > 0 AS link_relations
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
),

referrer_policy_headers AS (
  SELECT
    client,
    root_page,
    LOWER(response_header.value) AS header_policy
  FROM `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_header
  WHERE
    date = '2025-07-01' AND
    is_main_document = TRUE AND
    response_header.name = 'referrer-policy'
),

aggregated AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites,
    COUNT(DISTINCT IF(meta_policy IS NOT NULL, root_page, NULL)) / COUNT(DISTINCT root_page) AS pct_entire_document_policy_meta,
    COUNT(DISTINCT IF(header_policy IS NOT NULL, root_page, NULL)) / COUNT(DISTINCT root_page) AS pct_entire_document_policy_header,
    COUNT(DISTINCT IF(meta_policy IS NOT NULL OR header_policy IS NOT NULL, root_page, NULL)) / COUNT(DISTINCT root_page) AS pct_entire_document_policy,
    COUNT(DISTINCT IF(individual_requests, root_page, NULL)) / COUNT(DISTINCT root_page) AS pct_any_individual_requests,
    COUNT(DISTINCT IF(link_relations, root_page, NULL)) / COUNT(DISTINCT root_page) AS pct_any_link_relations,
    COUNT(DISTINCT IF(meta_policy IS NOT NULL OR header_policy IS NOT NULL OR individual_requests OR link_relations, root_page, NULL)) / COUNT(DISTINCT root_page) AS pct_any_referrer_policy
  FROM referrer_policy_custom_metrics
  FULL OUTER JOIN referrer_policy_headers
  USING (client, root_page)
  GROUP BY client
)

FROM aggregated,
  UNNEST([
    STRUCT('entire_document_policy_meta' AS metric, pct_entire_document_policy_meta AS pct),
    STRUCT('entire_document_policy_header', pct_entire_document_policy_header),
    STRUCT('entire_document_policy', pct_entire_document_policy),
    STRUCT('any_individual_requests', pct_any_individual_requests),
    STRUCT('any_link_relations', pct_any_link_relations),
    STRUCT('any_referrer_policy', pct_any_referrer_policy)
  ]) AS metric_data
|> SELECT client, metric_data.metric, metric_data.pct
|> PIVOT(
  ANY_VALUE(pct) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS Mobile, pct_desktop AS Desktop
|> ORDER BY mobile + desktop DESC
