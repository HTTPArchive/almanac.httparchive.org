#standardSQL
# Web Almanac — % / count of pages that contain common elements and roles
#
# What this does (applies to both sample and live):
#   • Elements: read element_count from custom_metrics.markup.element_count (preferred)
#               or custom_metrics.other.element_count (fallback)
#   • Roles:    read almanac from custom_metrics.other.almanac (preferred)
#               else legacy payload._almanac
#   • Map element↔role pairs: main↔main, header↔banner, nav↔navigation, footer↔contentinfo
#   • Aggregate per {client}: total_pages, element_usage, role_usage, both_usage, and percentages
#
# ===== SWITCH TARGET HERE =====================================================
# In `src_base`, keep the SAMPLE block for smoke tests, or switch to the LIVE block.
# ============================================================================

CREATE TEMPORARY FUNCTION getUsedRoles(almanac_str STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS r"""
try {
  const a = JSON.parse(almanac_str || "{}");
  const m = ((a || {}).nodes_using_role || {}).usage_and_count;
  if (!m || typeof m !== "object") return [];
  return Object.keys(m);
} catch (e) { return []; }
""";

CREATE TEMPORARY FUNCTION get_element_types(ec_str STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS r"""
try {
  if (!ec_str) return [];
  const m = JSON.parse(ec_str);
  if (!m || Array.isArray(m) || typeof m !== "object") return [];
  return Object.keys(m);
} catch (e) { return []; }
""";

WITH
-- ===== choose ONE of the two blocks below =====
src_base AS (
  -- SAMPLE (default)
  -- SELECT client, is_root_page, page, custom_metrics, payload
  -- FROM `httparchive.sample_data.pages_10k`

  -- LIVE (uncomment next 3 lines; and comment out the SAMPLE block above)
  SELECT client, is_root_page, page, custom_metrics, payload
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-07-01'
),
-- =============================================
mappings AS (
  SELECT 1 AS mapping_id, 'main'   AS element_type, 'main'        AS role_type UNION ALL
  SELECT 2 AS mapping_id, 'header' AS element_type, 'banner'      AS role_type UNION ALL
  SELECT 3 AS mapping_id, 'nav'    AS element_type, 'navigation'  AS role_type UNION ALL
  SELECT 4 AS mapping_id, 'footer' AS element_type, 'contentinfo' AS role_type
),
pages AS (
  SELECT client, page
  FROM src_base
  WHERE is_root_page = TRUE
),
elements AS (
  SELECT
    b.client,
    b.page,
    et AS element_type
  FROM src_base AS b
  JOIN pages USING (client, page)
  CROSS JOIN UNNEST(
    get_element_types(
      TO_JSON_STRING(
        COALESCE(b.custom_metrics.markup.element_count,
                 b.custom_metrics.other.element_count)
      )
    )
  ) AS et
  JOIN mappings m ON m.element_type = et
),
roles AS (
  SELECT
    b.client,
    b.page,
    rt AS role_type
  FROM src_base AS b
  JOIN pages USING (client, page)
  CROSS JOIN UNNEST(
    getUsedRoles(
      TO_JSON_STRING(
        COALESCE(b.custom_metrics.other.almanac,
                 JSON_QUERY(b.payload, '$._almanac'))
      )
    )
  ) AS rt
  JOIN mappings m ON m.role_type = rt
),
base AS (
  SELECT
    pg.client,
    pg.page,
    m.mapping_id,
    m.element_type,
    m.role_type,
    COUNTIF(e.element_type IS NOT NULL) AS element_usage,
    COUNTIF(r.role_type   IS NOT NULL)  AS role_usage
  FROM pages pg
  JOIN mappings m ON TRUE
  LEFT JOIN elements e
    ON e.client = pg.client AND e.page = pg.page AND e.element_type = m.element_type
  LEFT JOIN roles r
    ON r.client = pg.client AND r.page = pg.page AND r.role_type   = m.role_type
  GROUP BY pg.client, pg.page, m.mapping_id, m.element_type, m.role_type
)
SELECT
  client,
  mapping_id,
  element_type,
  role_type,
  COUNT(DISTINCT page)                                                                 AS total_pages,
  COUNTIF(element_usage > 0)                                                           AS element_usage,
  COUNTIF(role_usage   > 0)                                                            AS role_usage,
  COUNTIF(element_usage > 0 OR role_usage > 0)                                         AS both_usage,
  FORMAT('%.0f%%', 100 * SAFE_DIVIDE(COUNTIF(element_usage > 0), COUNT(DISTINCT page)))                 AS element_pct,
  FORMAT('%.0f%%', 100 * SAFE_DIVIDE(COUNTIF(role_usage    > 0), COUNT(DISTINCT page)))                 AS role_pct,
  FORMAT('%.0f%%', 100 * SAFE_DIVIDE(COUNTIF(element_usage > 0 OR role_usage > 0), COUNT(DISTINCT page))) AS both_pct
FROM base
GROUP BY client, mapping_id, element_type, role_type
ORDER BY client, mapping_id, element_type;
