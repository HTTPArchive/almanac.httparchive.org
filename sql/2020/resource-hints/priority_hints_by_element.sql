#standardSQL
# 21_08: Top tags that use priority hints
CREATE TEMPORARY FUNCTION getPriorityHints(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['priority-hints'].nodes.map(el => el.tagName);
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  tag,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST(getPriorityHints(payload)) AS tag
WHERE
  tag IS NOT NULL
GROUP BY
  client,
  tag
ORDER BY
  pct DESC
