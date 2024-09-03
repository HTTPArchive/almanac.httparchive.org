#standardSQL
# percentage/count of pages that contain common elements and roles

CREATE TEMPORARY FUNCTION getUsedRoles(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return Object.keys(almanac.nodes_using_role.usage_and_count);
} catch (e) {
  return [];
}
''';

CREATE TEMPORARY FUNCTION get_element_types(element_count_string STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    if (!element_count_string) return [];
    var element_count = JSON.parse(element_count_string);
    if (Array.isArray(element_count)) return [];
    if (typeof element_count != 'object') return [];
    return Object.keys(element_count);
} catch (e) {
    return [];
}
''';

WITH mappings AS (
  SELECT 1 AS mapping_id, 'main' AS element_type, 'main' AS role_type
  UNION ALL
  SELECT 2 AS mapping_id, 'header' AS element_type, 'banner' AS role_type
  UNION ALL
  SELECT 3 AS mapping_id, 'nav' AS element_type, 'navigation' AS role_type
  UNION ALL
  SELECT 4 AS mapping_id, 'footer' AS element_type, 'contentinfo' AS role_type
),

elements AS (
  SELECT
    client,
    page,
    is_root_page,
    element_type
  FROM
    `httparchive.all.pages`,
    UNNEST(get_element_types(JSON_EXTRACT_SCALAR(payload, '$._element_count'))) AS element_type
  JOIN
    mappings
  USING (element_type)
  WHERE
    date = '2024-06-01'
),

roles AS (
  SELECT
    client,
    page,
    is_root_page,
    role_type
  FROM
    `httparchive.all.pages`,
    UNNEST(getUsedRoles(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS role_type
  JOIN
    mappings
  USING (role_type)
  WHERE
    date = '2024-06-01'
),

base AS (
  SELECT
    e.client,
    e.page,
    e.is_root_page,
    m.mapping_id,
    m.element_type,
    m.role_type,
    COUNTIF(e.element_type IS NOT NULL) AS element_usage,
    COUNTIF(r.role_type IS NOT NULL) AS role_usage
  FROM
    elements e
  INNER JOIN
    mappings m
  ON 
    e.element_type = m.element_type
  LEFT JOIN
    roles r
  ON 
    e.client = r.client AND e.page = r.page AND e.is_root_page = r.is_root_page AND e.element_type = r.role_type
  GROUP BY
    e.client,
    e.page,
    e.is_root_page,
    m.mapping_id,
    m.element_type,
    m.role_type
),

total_pages_per_client_root AS (
  SELECT
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total_pages
  FROM
    base
  GROUP BY
    client,
    is_root_page
),

aggregated_usage AS (
  SELECT
    b.client,
    b.is_root_page,
    b.mapping_id,
    b.element_type,
    b.role_type,
    t.total_pages,
    COUNTIF(b.element_usage > 0) AS element_usage,
    COUNTIF(b.role_usage > 0) AS role_usage,
    COUNTIF(b.element_usage > 0 OR b.role_usage > 0) AS both_usage
  FROM
    base b
  JOIN
    total_pages_per_client_root t
  ON
    b.client = t.client AND b.is_root_page = t.is_root_page
  GROUP BY
    b.client,
    b.is_root_page,
    b.mapping_id,
    b.element_type,
    b.role_type,
    t.total_pages
)

SELECT
  client,
  is_root_page,
  mapping_id,
  element_type,
  role_type,
  total_pages,
  element_usage,
  role_usage,
  both_usage,
  SAFE_DIVIDE(element_usage, total_pages) AS element_pct,
  SAFE_DIVIDE(role_usage, total_pages) AS role_pct,
  SAFE_DIVIDE(both_usage, total_pages) AS both_pct
FROM
  aggregated_usage
ORDER BY
  client,
  is_root_page,
  mapping_id,
  element_type;
