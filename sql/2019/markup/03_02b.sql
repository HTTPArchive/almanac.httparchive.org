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
  htmlelement.name,
  SUM(htmlelement.freq) AS freq,
  SUM(SUM(htmlelement.freq)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(SUM(htmlelement.freq) * 100 / SUM(SUM(htmlelement.freq)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getElements(payload)) AS htmlelement
GROUP BY
  client,
  htmlelement.name
ORDER BY
  freq / total DESC,
  client
LIMIT
  10000
