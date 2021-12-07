#standardSQL
# 21_09: Top importance values on priority hints.
CREATE TEMPORARY FUNCTION getPriorityHintImportance(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['priority-hints'].nodes.map(el => el.importance);
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  importance,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST(getPriorityHintImportance(payload)) AS importance
GROUP BY
  client,
  importance
ORDER BY
  pct DESC
