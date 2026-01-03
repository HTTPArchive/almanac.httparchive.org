-- standardSQL
-- Web Almanac — %/count of pages with common landmarks & roles
-- Google Sheet: landmark_elements_and_roles
--
-- What this query does (keeps 2024 result shape):
--   • Maps elements→roles (main/banner/navigation/contentinfo) via a small CTE.
--   • For each page, flags presence of the mapped HTML element and corresponding ARIA role.
--   • Aggregates per {client, mapping_id, element_type, role_type}: totals + percentages.
--
-- 2025 transition choices (no JS UDFs; new JSON locations):
--   • Source: use 2025 JSON in `custom_metrics.other.almanac` (JSON-typed); fallback to legacy `payload._almanac`.
--   • Parsing: replace JS UDFs with native JSON functions:
--       - Elements:  JSON_KEYS(JSON_QUERY(almanac, '$.element_count'))
--       - Roles:     JSON_KEYS(JSON_QUERY(almanac, '$.nodes_using_role.usage_and_count'))
--     This avoids stringifying and reduces cost vs parsing in JS.
--   • Structure preserved: same CTE layout (mappings/elements/roles/base) and the same outputs
--     (total_pages, element_usage/role_usage/both_usage and element_pct/role_pct/both_pct).
--
-- Practical notes:
--   • Cost: filter by partition (`date`) and `is_root_page` early in `src`.
--   • Sampling: swap the FROM to `httparchive.sample_data.pages_10k` and comment the date filter if needed.
--   • If any JSON path is missing, COALESCE keeps rows but those pages won’t contribute keys.
-- standardSQL
-- %/count of pages that contain common elements and roles (2025 schema; 2024 shape)

WITH mappings AS (
  SELECT 1 AS mapping_id, 'main' AS element_type, 'main' AS role_type
  UNION ALL
  SELECT 2 AS mapping_id, 'header' AS element_type, 'banner' AS role_type
  UNION ALL
  SELECT 3 AS mapping_id, 'nav' AS element_type, 'navigation' AS role_type
  UNION ALL
  SELECT 4 AS mapping_id, 'footer' AS element_type, 'contentinfo' AS role_type
),

-- Read once; keep roles (almanac) and elements (element_count) separate
src AS (
  SELECT
    client,
    page,
    is_root_page,
    -- Roles live in the Almanac blob in 2025
    COALESCE(
      custom_metrics.other.almanac,
      JSON_QUERY(payload, '$._almanac')
    ) AS almanac,
    -- Elements do NOT live in the almanac; use element_count metric
    COALESCE(
      custom_metrics.element_count,                 -- primary (JSON-typed)
      custom_metrics.other.element_count,           -- if nested under other
      JSON_QUERY(payload, '$.element_count')        -- legacy fallback
    ) AS element_count
  FROM
    `httparchive.crawl.pages`
    -- `httparchive.sample_data.pages_10k`
  WHERE is_root_page AND
    date = DATE '2025-07-01' -- Comment out if `httparchive.sample_data.pages_10k`,
),

elements AS (
  SELECT
    s.client,
    s.page,
    element_type
  FROM src AS s,
    UNNEST(JSON_KEYS(s.element_count)) AS element_type
  JOIN mappings USING (element_type)
),

roles AS (
  SELECT
    s.client,
    s.page,
    role_type
  FROM src AS s,
    UNNEST(JSON_KEYS(JSON_QUERY(s.almanac, '$.nodes_using_role.usage_and_count'))) AS role_type
  JOIN mappings USING (role_type)
),

base AS (
  SELECT
    s.client,
    s.page,
    m.mapping_id,
    m.element_type,
    m.role_type,
    COUNTIF(e.element_type IS NOT NULL) AS element_usage,
    COUNTIF(r.role_type IS NOT NULL) AS role_usage
  FROM src AS s
  INNER JOIN mappings AS m ON TRUE
  LEFT JOIN elements AS e USING (client, page, element_type)
  LEFT JOIN roles AS r USING (client, page, role_type)
  GROUP BY s.client, s.page, m.mapping_id, m.element_type, m.role_type
)

SELECT
  client,
  mapping_id,
  element_type,
  role_type,
  COUNT(DISTINCT page) AS total_pages,
  COUNTIF(element_usage > 0) AS element_usage,
  COUNTIF(role_usage > 0) AS role_usage,
  COUNTIF(element_usage > 0 OR role_usage > 0) AS both_usage,
  COUNTIF(element_usage > 0) / COUNT(DISTINCT page) AS element_pct,
  COUNTIF(role_usage > 0) / COUNT(DISTINCT page) AS role_pct,
  COUNTIF(element_usage > 0 OR role_usage > 0) / COUNT(DISTINCT page) AS both_pct
FROM base
GROUP BY client, mapping_id, element_type, role_type
ORDER BY client, mapping_id, element_type;
