#standardSQL
# 21_07: % of sites that use priority hints.
CREATE TEMPORARY FUNCTION hasPriorityHints(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['priority-hints'].nodes.length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(has_hint) AS freq,
  COUNT(0) AS total,
  COUNTIF(has_hint) / COUNT(0) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    hasPriorityHints(payload) AS has_hint
  FROM
    `httparchive.pages.2020_08_01_*`)
GROUP BY
  client
