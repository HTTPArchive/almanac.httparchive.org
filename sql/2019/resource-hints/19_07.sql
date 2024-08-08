#standardSQL
# 19_07: % of sites that use priority hints.
CREATE TEMPORARY FUNCTION getPriorityHints(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['priority-hints'].length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(has_hint) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(has_hint) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getPriorityHints(payload) AS has_hint
  FROM
    `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
