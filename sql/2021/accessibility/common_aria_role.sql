#standardSQL
# % of sites using each type of aria role
CREATE TEMPORARY FUNCTION getUsedRoles(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return Object.keys(almanac.nodes_using_role.usage_and_count);
} catch (e) {
  return [];
}
''';
SELECT
  _TABLE_SUFFIX AS client,
  total_sites,
  role,
  COUNT(0) AS total_sites_using,
  COUNT(0) / total_sites AS pct_sites_using
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getUsedRoles(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS role
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_sites
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
GROUP BY
  client,
  role,
  total_sites
HAVING
  total_sites_using >= 100
ORDER BY
  pct_sites_using DESC
