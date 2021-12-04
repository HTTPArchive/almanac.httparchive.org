#standardSQL
# 03_02b: Top elements
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
  SUM(element.freq) AS freq,
  SUM(SUM(element.freq)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(SUM(element.freq) * 100 / SUM(SUM(element.freq)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getElements(payload)) AS element
GROUP BY
  client,
  element.name
ORDER BY
  freq / total DESC,
  client
LIMIT 10000
