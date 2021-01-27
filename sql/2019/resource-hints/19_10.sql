#standardSQL
# 19_10: Top tag/importance combinations on priority hints.
CREATE TEMPORARY FUNCTION getPriorityHints(payload STRING)
RETURNS ARRAY<STRUCT<tag STRING, importance STRING>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['priority-hints'].map(el => {
    return {
      tag: el.tagName,
      importance: el.importance
    };
  });
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  hint.tag,
  hint.importance,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getPriorityHints(payload)) AS hint
GROUP BY
  client,
  tag,
  importance
ORDER BY
  freq DESC
