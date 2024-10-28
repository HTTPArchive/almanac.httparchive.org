#standardSQL
# Section: Security misconfigurations - CSP directives that are ignored in <meta>
# Question: How many pages use invalid CSP directives in <meta>?
# Note: uses the old payload._almanac metric location instead of custom_metrics.almanac (also the meta-nodes metric is in the generic almanac.js custom metric)
SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(CASE WHEN REGEXP_CONTAINS(LOWER(JSON_VALUE(meta_node, '$.content')), r'(?i)frame-ancestors') THEN page END) AS count_frame_ancestors,
  COUNT(CASE WHEN REGEXP_CONTAINS(LOWER(JSON_VALUE(meta_node, '$.content')), r'(?i)frame-ancestors') THEN page END) / COUNT(DISTINCT page) AS pct_frame_ancestors,
  COUNT(CASE WHEN REGEXP_CONTAINS(LOWER(JSON_VALUE(meta_node, '$.content')), r'(?i)sandbox( allow-[a-z]+)*;') THEN page END) AS count_sandbox,
  COUNT(CASE WHEN REGEXP_CONTAINS(LOWER(JSON_VALUE(meta_node, '$.content')), r'(?i)sandbox( allow-[a-z]+)*;') THEN page END) / COUNT(DISTINCT page) AS pct_sandbox
FROM (
  SELECT
    client,
    page,
    JSON_VALUE(payload, '$._almanac') AS metrics
  FROM
    `httparchive.all.pages.`
  WHERE
    date = '2024-06-01' AND
    is_root_page
),
UNNEST(JSON_QUERY_ARRAY(metrics, '$.meta-nodes.nodes')) meta_node,
UNNEST(['Content-Security-Policy']) AS policy
WHERE
  LOWER(JSON_VALUE(meta_node, '$.http-equiv')) = 'content-security-policy' OR LOWER(JSON_VALUE(meta_node, '$.name')) = 'content-security-policy'
GROUP BY
  client
