#standardSQL
# 03_02a: % of pages having elements
CREATE TEMPORARY FUNCTION getElements(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return [];
  return Object.keys(elements);
} catch (e) {
  return [];
}
''';

 SELECT
  _TABLE_SUFFIX AS client,
  element,
  COUNT(DISTINCT url) AS pages,
  total,
  ROUND(COUNT(DISTINCT url) * 100 / total, 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`
JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX),
  UNNEST(getElements(payload)) AS element
GROUP BY
  client,
  total,
  element
ORDER BY
  pages / total DESC,
  client
