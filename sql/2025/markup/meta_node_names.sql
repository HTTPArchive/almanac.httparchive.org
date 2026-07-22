CREATE TEMPORARY FUNCTION getMetaNodes(metanodes JSON)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
if (!metanodes) return [];
return metanodes.nodes.map(n => n.name || n.property);
''';

WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY
    client
)

SELECT
  client,
  IF(IFNULL(TRIM(name), '') = '', '(not set)', name) AS name,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct_nodes,
  COUNT(DISTINCT page) AS num_urls,
  COUNT(DISTINCT page) / total_pages AS pct_pages
FROM
  `httparchive.crawl.pages`,
  UNNEST(ARRAY(
    SELECT
      COALESCE(
        STRING(node.name),
        STRING(node.property)
      )
    FROM UNNEST(JSON_QUERY_ARRAY(custom_metrics.other.almanac.`meta-nodes`.nodes)) AS node
  )) AS name
JOIN
  totals
USING (client)
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  total_pages,
  name
HAVING
  COUNT(0) > 1
ORDER BY
  pct_nodes DESC
LIMIT
  200
