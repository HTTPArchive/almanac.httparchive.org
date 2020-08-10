#standardSQL
# % of pages having elements M241
# See related: sql/2019/03_Markup/03_02a.sql

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

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
  AS_PERCENT(COUNT(DISTINCT url), total) AS pct
FROM
  `httparchive.sample_data.pages_*`
JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.sample_data.pages_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX),
  UNNEST(getElements(payload)) AS element
GROUP BY
  client,
  total,
  element
ORDER BY
  pages / total DESC,
  client
