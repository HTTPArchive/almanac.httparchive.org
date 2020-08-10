#standardSQL
# Top used elements
# See related: sql/2019/03_Markup/03_02b.sql

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

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
  AS_PERCENT(SUM(element.freq), SUM(SUM(element.freq)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct # M202
FROM
  `httparchive.sample_data.pages_*`,
  UNNEST(getElements(payload)) AS element
GROUP BY
  client,
  element.name
ORDER BY
  client,
  pct DESC
LIMIT
  10000
