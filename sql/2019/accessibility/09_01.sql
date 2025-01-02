#standardSQL
# 09_01: % of pages having headings
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
JOIN (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX),
  UNNEST(getElements(payload)) AS element
WHERE
  element IN ('h1', 'h2', 'h3', 'h4', 'h5', 'h6')
GROUP BY
  client,
  total,
  element
ORDER BY
  pages / total DESC,
  client
