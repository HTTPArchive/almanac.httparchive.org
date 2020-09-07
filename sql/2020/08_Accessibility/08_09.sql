#standardSQL
# 08_09: How often pages contain an element with a given attribute
CREATE TEMPORARY FUNCTION getUsedAttributes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return Object.keys(almanac.attributes_used_on_elements);
} catch (e) {
  return [];
}
''';
SELECT
  _TABLE_SUFFIX AS client,
  total_sites,
  attribute,
  COUNT(0) AS total_sites_using,
  ROUND((COUNT(0) / total_sites) * 100, 2) AS pct_sites_using
FROM
  `httparchive.almanac.pages_desktop_*`,
  UNNEST(getUsedAttributes(JSON_EXTRACT_SCALAR(payload, "$._almanac"))) AS attribute
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
  attribute,
  total_sites
HAVING
  total_sites_using > 100
ORDER BY
  pct_sites_using DESC
