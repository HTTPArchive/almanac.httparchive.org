#standardSQL
# How often pages contain an element with a given attribute
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
  COUNT(0) / total_sites AS pct_sites_using
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getUsedAttributes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS attribute
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
  attribute,
  total_sites
HAVING
  STARTS_WITH(attribute, 'aria-') OR
  pct_sites_using >= 0.01
ORDER BY
  pct_sites_using DESC
