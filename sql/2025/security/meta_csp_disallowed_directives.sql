#standardSQL
# Section: Security misconfigurations - CSP directives that are ignored in <meta>
# Question: How many pages use invalid CSP directives in <meta>?
# Note: uses the old payload._almanac metric location instead of custom_metrics.almanac (also the meta-nodes metric is in the generic almanac.js custom metric)
WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  total_pages,
  COUNT(DISTINCT page) AS total_pages_with_csp_meta,
  COUNT(CASE WHEN REGEXP_CONTAINS(LOWER(JSON_VALUE(meta_node, '$.content')), r'(?i)frame-ancestors') THEN page END) AS count_frame_ancestors,
  COUNT(CASE WHEN REGEXP_CONTAINS(LOWER(JSON_VALUE(meta_node, '$.content')), r'(?i)frame-ancestors') THEN page END) / COUNT(DISTINCT page) AS pct_frame_ancestors,
  COUNT(CASE WHEN REGEXP_CONTAINS(LOWER(JSON_VALUE(meta_node, '$.content')), r'(?i)sandbox( allow-[a-z]+)*;') THEN page END) AS count_sandbox,
  COUNT(CASE WHEN REGEXP_CONTAINS(LOWER(JSON_VALUE(meta_node, '$.content')), r'(?i)sandbox( allow-[a-z]+)*;') THEN page END) / COUNT(DISTINCT page) AS pct_sandbox
FROM (
  SELECT
    client,
    page,
    custom_metrics.other.almanac as metrics
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
),
  UNNEST(JSON_QUERY_ARRAY(metrics, '$.meta-nodes.nodes')) meta_node,
  UNNEST(['Content-Security-Policy']) AS policy
JOIN totals USING (client)
WHERE
  LOWER(JSON_VALUE(meta_node, '$.http-equiv')) = 'content-security-policy' OR LOWER(JSON_VALUE(meta_node, '$.name')) = 'content-security-policy'
GROUP BY
  client,
  total_pages