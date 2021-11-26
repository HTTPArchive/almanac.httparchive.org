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
    _TABLE_SUFFIX,
    url,
    element_type
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(get_element_types(JSON_EXTRACT_SCALAR(payload, '$._element_count'))) AS element_type
  JOIN
    mappings
  USING (element_type)
),

roles AS (
  SELECT
    _TABLE_SUFFIX,
    url,
    role_type
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getUsedRoles(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS role_type
  JOIN
    mappings
  USING (role_type)
),

base AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    mapping_id,
    element_type,
    role_type,
    COUNTIF(e.element_type IS NOT NULL) AS element_usage,
    COUNTIF(r.role_type IS NOT NULL) AS role_usage
  FROM
    `httparchive.pages.2021_07_01_*`
  INNER JOIN mappings ON (TRUE)
  LEFT OUTER JOIN
    elements e
  USING (_TABLE_SUFFIX, url, element_type)
  LEFT OUTER JOIN
    roles r
  USING (_TABLE_SUFFIX, url, role_type)
  GROUP BY
    client,
    url,
    mapping_id,
    element_type,
    role_type
)

SELECT
  client,
  mapping_id,
  element_type,
  role_type,
  COUNT(DISTINCT url) AS total_pages,
  COUNTIF(element_usage > 0) AS element_usage,
  COUNTIF(role_usage > 0) AS role_usage,
  COUNTIF(element_usage > 0 OR role_usage > 0) AS both_usage,
  COUNTIF(element_usage > 0) / COUNT(DISTINCT url) AS element_pct,
  COUNTIF(role_usage > 0) / COUNT(DISTINCT url) AS role_pct,
  COUNTIF(element_usage > 0 OR role_usage > 0) / COUNT(DISTINCT url) AS both_pct
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
