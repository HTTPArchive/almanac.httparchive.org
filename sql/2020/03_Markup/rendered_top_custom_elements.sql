#standardSQL
# Top custom elements ("slang")
# See related: sql/2019/03_Markup/03_03b.sql
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
  custom_element,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.almanac.pages_*`,
  UNNEST(getCustomElements(payload)) AS custom_element
GROUP BY
  client,
  custom_element
ORDER BY
  freq / total DESC,
  client
