#standardSQL
# meta nodes

CREATE TEMPORARY FUNCTION getMetaNodes(payload STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['meta-nodes'].nodes.map(n => n.name || n.property);
} catch (e) {
  return [];
}
''' ;

SELECT
  _TABLE_SUFFIX AS client,
  IF(IFNULL(TRIM(name), '') = '', '(not set)', name) AS name,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getMetaNodes(payload)) AS name
GROUP BY
  client,
  name
HAVING
  freq > 1
ORDER BY
  pct DESC,
  client,
  name
LIMIT 200
