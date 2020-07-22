#standardSQL
# % of pages having specific custom elements
# See related: sql/2019/03_Markup/03_03c.sql
CREATE TEMPORARY FUNCTION getCustomElements(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return [];
  return Object.keys(elements).filter(e => e.includes('-'));
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
  `httparchive.almanac.pages_*`
JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.almanac.pages_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX),
  UNNEST(getCustomElements(payload)) AS element
GROUP BY
  client,
  total,
  element
ORDER BY
  pct DESC,
  client
LIMIT 10000
