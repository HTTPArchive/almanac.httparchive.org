CREATE TEMPORARY FUNCTION getMetaNodes(custom_metrics STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
try {
  var almanac = JSON.parse(custom_metrics);
  return almanac['meta-nodes'].nodes.map(n => n.name || n.property);
} catch (e) {
  return [];
}
''';

WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
),

meta AS (
  SELECT
    client,
    IF(IFNULL(TRIM(name), '') = '', '(not set)', name) AS name,
    COUNT(0) AS freq,
    COUNT(0) / SUM(COUNT(0)) OVER () AS pct_nodes,
    COUNT(DISTINCT page) AS num_urls,
    COUNT(DISTINCT page) / total_pages AS pct_pages
  FROM
    `httparchive.all.pages`,
    UNNEST(getMetaNodes(JSON_EXTRACT(custom_metrics, '$.almanac'))) AS name
  JOIN
    totals
  USING
    (client)
  WHERE
    date = '2024-06-01'
  GROUP BY
    client,
    total_pages,
    name
)

SELECT
  *
FROM
  meta
WHERE
  freq > 1
ORDER BY
  pct_nodes DESC
LIMIT
  200
