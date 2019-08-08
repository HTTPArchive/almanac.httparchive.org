#standardSQL
# 03_02b: Top elements
CREATE TEMPORARY FUNCTION getElements(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count)
  return Object.keys(elements);
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  element,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getElements(payload)) AS element
GROUP BY
  client,
  element
ORDER BY
  freq / total DESC,
  client