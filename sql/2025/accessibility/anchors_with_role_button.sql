-- standardSQL
-- Web Almanac — Share of sites that use <a role="button">
--
-- What this does
--   • Computes site-level adoption of the accessibility pattern <a role="button">.
--   • Uses host-level aggregation to avoid over-counting pages from the same site.
--   • Distinguishes between root and non-root pages.
--
-- Method
--   1. Extract a canonical URL string per page (prefer performance.lcp_resource.documentURL,
--      fallback to canonicals.url, payload.url, or payload._url).
--   2. Keep only http/https URLs and normalize them with NET.HOST() as the site key.
--   3. From custom_metrics:
--        - total_anchors_with_role_button: a11y.total_anchors_with_role_button
--        - total_a_elements: element_count.a
--   4. For each (client, is_root_page, host), set flags:
--        - has_any_a              → true if any sampled page on the host has <a> elements
--        - has_anchor_role_button → true if any sampled page has <a role="button">
--   5. Count DISTINCT hosts per group that meet each condition.
--
-- Safety
--   • SAFE_CAST used for metrics extraction.
--   • TO_JSON_STRING() ensures JSON_VALUE works on nested custom_metrics objects.
--   • Optionally enable TABLESAMPLE for smoke tests; remove for full crawl.
--
-- Output columns
--   client                          — "desktop" | "mobile"
--   is_root_page                    — boolean (true if root page)
--   sites_with_anchors              — distinct sites that have at least one <a>
--   sites_with_anchor_role_button   — distinct sites that have at least one <a role="button">
--   pct_sites_with_anchor_role_button — formatted percentage (of sites with <a>)
--
WITH per_page AS (
  SELECT
    client,
    is_root_page,
    COALESCE(
      JSON_VALUE(custom_metrics.performance, '$.lcp_resource.documentURL'),
      JSON_VALUE(TO_JSON_STRING(custom_metrics), '$.canonicals.url'),
      JSON_VALUE(payload, '$.url'),
      JSON_VALUE(payload, '$._url')
    ) AS url_str,
    SAFE_CAST(JSON_VALUE(custom_metrics.a11y, '$.total_anchors_with_role_button') AS INT64)
      AS anchors_role_button,
    SAFE_CAST(JSON_VALUE(TO_JSON_STRING(custom_metrics), '$.element_count.a') AS INT64)
      AS total_a_elements
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)   -- ← optional: cheap smoke test
  WHERE date = '2025-07-01'
),
per_site AS (
  SELECT
    client,
    is_root_page,
    NET.HOST(url_str) AS host,
    LOGICAL_OR(total_a_elements > 0) AS has_any_a,
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
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(has_anchor_role_button), COUNTIF(has_any_a)))
    AS pct_sites_with_anchor_role_button
FROM per_site
GROUP BY client, is_root_page
ORDER BY client, is_root_page DESC;
