#standardSQL
# Top elements
# See related: sql/2019/03_Markup/03_02b.sql
CREATE TEMPORARY FUNCTION getElements(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return [];
  return Object.entries(elements).map(([name, freq]) => ({name, freq}));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  element.name,
  SUM(element.freq) AS freq, # M201 - total count from all pages
  ROUND(SUM(element.freq) * 100 / SUM(SUM(element.freq)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct, # M202
  SUM(SUM(element.freq)) OVER (PARTITION BY _TABLE_SUFFIX) AS total # M203 all elements count for a device. Don't see its value?
FROM
  `httparchive.almanac.pages_*`,
  UNNEST(getElements(payload)) AS element
GROUP BY
  client,
  element.name
ORDER BY
  freq / total DESC,
  client
LIMIT
  10000
