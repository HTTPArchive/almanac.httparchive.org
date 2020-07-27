#standardSQL
# 21_09: Top importance values on priority hints.
CREATE TEMPORARY FUNCTION getPriorityHints(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['priority-hints'].map(el => el.importance);
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  importance,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.almanac.pages` WHERE edition = "2020",
  UNNEST(getPriorityHints(payload)) AS importance
WHERE
  importance IS NOT NULL
GROUP BY
  client,
  importance
ORDER BY
  freq DESC