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
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  IF(IFNULL(TRIM(name), '') = '', '(not set)', name) AS name,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct_nodes,
  COUNT(DISTINCT url) AS num_urls,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getMetaNodes(payload)) AS name
JOIN
  totals
USING
  (_TABLE_SUFFIX)
GROUP BY
  client,
  total_pages,
  name
HAVING
  freq > 1
ORDER BY
  pct_nodes DESC,
  client,
  name
LIMIT 200
