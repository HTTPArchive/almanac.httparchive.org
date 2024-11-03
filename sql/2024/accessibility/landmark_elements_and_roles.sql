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
    if (!element_count_string) return []; // 2019 had a few cases

    var element_count = JSON.parse(element_count_string); // should be an object with element type properties with values of how often they are present

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
    element_type
  FROM
    `httparchive.all.pages`,
    UNNEST(get_element_types(JSON_EXTRACT(custom_metrics, '$.element_count'))) AS element_type
  JOIN
    mappings
  USING (element_type)
  WHERE
    date = '2024-06-01' AND
    is_root_page
),

roles AS (
  SELECT
    client,
    page,
    role_type
  FROM
    `httparchive.all.pages`,
    UNNEST(getUsedRoles(JSON_EXTRACT(custom_metrics, '$.almanac'))) AS role_type
  JOIN
    mappings
  USING (role_type)
  WHERE
    date = '2024-06-01' AND
    is_root_page
),

base AS (
  SELECT
    client,
    page,
    mapping_id,
    element_type,
    role_type,
    COUNTIF(e.element_type IS NOT NULL) AS element_usage,
    COUNTIF(r.role_type IS NOT NULL) AS role_usage
  FROM
    `httparchive.all.pages`
  INNER JOIN mappings ON (TRUE)
  LEFT OUTER JOIN
    elements e
  USING (client, page, element_type)
  LEFT OUTER JOIN
    roles r
  USING (client, page, role_type)
  WHERE
    date = '2024-06-01' AND
    is_root_page
  GROUP BY
    client,
    page,
    mapping_id,
    element_type,
    role_type
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
FROM
  base
GROUP BY
  client,
  mapping_id,
  element_type,
  role_type
ORDER BY
  client,
  mapping_id,
  element_type
