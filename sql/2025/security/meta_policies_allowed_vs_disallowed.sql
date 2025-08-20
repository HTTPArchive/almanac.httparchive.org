#standardSQL
# Section: Attack preventions - Preventing attacks using <meta>
# Question: How many pages use security policies in meta tags (both allowed and ignored ones)
# Note: uses the old payload._almanac metric location instead of custom_metrics.almanac (also the meta-nodes metric is in the generic almanac.js custom metric)
SELECT
  client,
  policy,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT(CASE WHEN LOWER(JSON_VALUE(meta_node, '$.http-equiv')) = LOWER(policy) OR LOWER(JSON_VALUE(meta_node, '$.name')) = LOWER(policy) THEN page END)) AS count_policy,
  COUNT(DISTINCT(CASE WHEN LOWER(JSON_VALUE(meta_node, '$.http-equiv')) = LOWER(policy) OR LOWER(JSON_VALUE(meta_node, '$.name')) = LOWER(policy) THEN page END)) / COUNT(DISTINCT page) AS pct_policy,
  policy IN ('Content-Security-Policy', 'referrer') AS is_allowed_as_meta
FROM (
  SELECT
    client,
    page,
    custom_metrics.other.almanac AS metrics
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
),
  UNNEST(JSON_QUERY_ARRAY(metrics, '$.meta-nodes.nodes')) meta_node,
  UNNEST(['Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy', 'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'referrer', 'Report-To', 'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection']) AS policy
GROUP BY
  client,
  policy
ORDER BY
  client,
  count_policy DESC
