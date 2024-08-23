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

WITH element_role_usage AS (
  SELECT
    page,
    is_root_page,
    element_type,
    role_type
  FROM
    `httparchive.all.pages`,
    UNNEST(get_element_types(JSON_EXTRACT_SCALAR(payload, '$._element_count'))) AS element_type
  LEFT JOIN
    UNNEST(getUsedRoles(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS role_type
  ON element_type = role_type
  WHERE
    date = '2024-06-01'
),

aggregated_usage AS (
  SELECT
    element_type,
    role_type,
    COUNT(DISTINCT page) AS total_pages,
    COUNTIF(element_type IS NOT NULL) AS element_usage,
    COUNTIF(role_type IS NOT NULL) AS role_usage
  FROM
    element_role_usage
  GROUP BY
    element_type,
    role_type
)

SELECT
  element_type,
  role_type,
  total_pages,
  element_usage,
  role_usage,
  element_usage / total_pages AS element_pct,
  role_usage / total_pages AS role_pct
FROM
  aggregated_usage
ORDER BY
  element_type,
  role_type;
