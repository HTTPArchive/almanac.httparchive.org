SELECT
  client,
  policy,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT(CASE WHEN LOWER(JSON_VALUE(meta_node, '$.http-equiv')) = LOWER(policy) OR LOWER(JSON_VALUE(meta_node, '$.name')) = LOWER(policy) THEN page END)) AS count_policy,
  COUNT(DISTINCT(CASE WHEN LOWER(JSON_VALUE(meta_node, '$.http-equiv')) = LOWER(policy) OR LOWER(JSON_VALUE(meta_node, '$.name')) = LOWER(policy) THEN page END)) / COUNT(DISTINCT page) AS pct_policy,
  policy IN ('Content-Security-Policy', 'referrer') AS is_allowed_as_meta
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_VALUE(payload, "$._almanac") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
),
UNNEST(JSON_QUERY_ARRAY(metrics, "$.meta-nodes.nodes")) meta_node,
UNNEST(['Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy', 'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'referrer', 'Report-To', 'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection']) AS policy
GROUP BY
  client,
  policy
ORDER BY
  client,
  policy,
  count_policy DESC
