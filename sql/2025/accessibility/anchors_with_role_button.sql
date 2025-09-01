-- HTTP Archive Almanac 2025 (match 2024 structure)
-- Metric: share of SITES that have at least one <a role="button">
-- Grouping: client, is_root_page (do NOT merge root/non-root)
-- Method:
--   1) Determine a canonical-ish URL string per row (page) from a few fields.
--   2) Keep only http(s) URLs and extract NET.HOST() as the site key.
--   3) From custom_metrics:
--        - total_anchors_with_role_button: a11y.total_anchors_with_role_button
--        - total_a_elements: element_count.a
--   4) For each (client, is_root_page, host) decide:
--        - has_any_a                := max(total_a_elements > 0)
--        - has_anchor_role_button   := max(total_anchors_with_role_button > 0)
--   5) Count DISTINCT hosts per group that satisfy each condition.
-- Sampling:
--   - TABLESAMPLE SYSTEM (.1 PERCENT) for approximate results.
-- Safety:
--   - SAFE_CAST / JSON_VALUE with TO_JSON_STRING() where needed.

-- standardSQL
WITH per_page AS (
  SELECT
    client,
    is_root_page,
    -- canonical-ish URL with fallbacks
    COALESCE(
      JSON_VALUE(custom_metrics.performance, '$.lcp_resource.documentURL'),
      JSON_VALUE(TO_JSON_STRING(custom_metrics), '$.canonicals.url'),
      JSON_VALUE(payload, '$.url'),
      JSON_VALUE(payload, '$._url')
    ) AS url_str,

    -- metrics from custom_metrics
    SAFE_CAST(JSON_VALUE(custom_metrics.a11y, '$.total_anchors_with_role_button') AS INT64)
      AS anchors_role_button,
    SAFE_CAST(JSON_VALUE(TO_JSON_STRING(custom_metrics), '$.element_count.a') AS INT64)
      AS total_a_elements
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
),
per_site AS (
  -- One row per (client, is_root_page, host) with boolean flags
  SELECT
    client,
    is_root_page,
    NET.HOST(url_str) AS host,
    -- A site “has any a” if ANY sampled page on that site has > 0 <a>
    LOGICAL_OR(total_a_elements > 0) AS has_any_a,
    -- A site “has anchor role button” if ANY sampled page has > 0 <a role="button">
    LOGICAL_OR(anchors_role_button > 0) AS has_anchor_role_button
  FROM per_page
  WHERE url_str IS NOT NULL
    AND (STARTS_WITH(url_str, 'http://') OR STARTS_WITH(url_str, 'https://'))
  GROUP BY client, is_root_page, host
)
SELECT
  client,
  is_root_page,
  COUNTIF(has_any_a) AS sites_with_anchors,
  COUNTIF(has_anchor_role_button) AS sites_with_anchor_role_button,
  SAFE_DIVIDE(
    COUNTIF(has_anchor_role_button),
    COUNTIF(has_any_a)
  ) AS pct_sites_with_anchor_role_button
FROM per_site
GROUP BY client, is_root_page
ORDER BY client, is_root_page DESC;
