-- standardSQL
-- Web Almanac — % of sites using each ARIA role (2025 JSON; 2024-style output)
--
-- What this does
--   • Reads the 2025 JSON object at: custom_metrics.other.almanac
--   • Extracts role names from: almanac.nodes_using_role.usage_and_count (object of {role: count})
--   • Expands those role keys to rows, then aggregates by {client, is_root_page, role}
--   • Returns 2024-style columns:
--       client, is_root_page, total_sites, role, total_sites_using, pct_sites_using
--   • pct_sites_using is formatted like "12.3%" (human-readable).
--
-- Notes
--   • The HAVING threshold is reduced (>= 10) since the sample is small.

WITH role_usage AS (
  SELECT
    p.client,
    p.is_root_page,
    p.page,
    role
  FROM `httparchive.crawl.pages` AS p
  CROSS JOIN UNNEST(
    JSON_KEYS(p.custom_metrics.other.almanac.nodes_using_role.usage_and_count)
  ) AS role
  WHERE p.custom_metrics.other.almanac IS NOT NULL
    AND JSON_TYPE(p.custom_metrics.other.almanac.nodes_using_role.usage_and_count) = 'object'
    AND date = '2025-07-01'
),

totals AS (
  SELECT
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total_sites
  FROM role_usage
  GROUP BY client, is_root_page
)

SELECT
  r.client,
  r.is_root_page,
  t.total_sites,
  r.role,
  COUNT(DISTINCT r.page) AS total_sites_using,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNT(DISTINCT r.page), t.total_sites)) AS pct_sites_using
FROM role_usage r
JOIN totals t
  ON r.client = t.client AND r.is_root_page = t.is_root_page
GROUP BY r.client, r.is_root_page, t.total_sites, r.role
HAVING COUNT(DISTINCT r.page) >= 10      -- lower threshold for sample table
ORDER BY SAFE_DIVIDE(COUNT(DISTINCT r.page), t.total_sites) DESC,
         r.client, r.is_root_page, r.role;
