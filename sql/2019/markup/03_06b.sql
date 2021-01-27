#standardSQL
# 03_06b: Element types per page
CREATE TEMPORARY FUNCTION countElementTypes(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return null;
  return Object.keys(elements).length;
} catch (e) {
  return null;
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  countElementTypes(payload) AS element_types,
  COUNT(0) AS freq
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client,
  element_types
HAVING
  element_types IS NOT NULL
ORDER BY
  element_types,
  client
