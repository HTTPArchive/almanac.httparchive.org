#standardSQL
# 08_10: % of sites using each type of aria role
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
  ROUND((COUNT(0) / total_sites) * 100, 2) AS pct_sites_using
FROM
  `httparchive.almanac.pages_desktop_*`,
  UNNEST(getUsedRoles(JSON_EXTRACT_SCALAR(payload, "$._almanac"))) AS role
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_sites
  FROM
    `httparchive.almanac.pages_desktop_*`
  GROUP BY _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
GROUP BY
  client,
  role,
  total_sites
ORDER BY
  pct_sites_using DESC
