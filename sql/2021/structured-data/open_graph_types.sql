# standardSQL
# Count Open Graph types
CREATE TEMP FUNCTION getOpenGraphTypes(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  try {
    rendered = JSON.parse(rendered);
    return rendered.opengraph.map(opengraph => opengraph.property.toLowerCase());
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    getOpenGraphTypes(rendered) AS open_graph_types,
    client
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered,
      _TABLE_SUFFIX AS client
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  open_graph_type,
  COUNT(open_graph_type) AS count,
  SUM(COUNT(open_graph_type)) OVER (PARTITION BY client) AS total,
  COUNT(open_graph_type) / SUM(COUNT(open_graph_type)) OVER (PARTITION BY client) AS pct,
  client
FROM
  rendered_data,
  UNNEST(open_graph_types) AS open_graph_type
GROUP BY
  open_graph_type,
  client
ORDER BY
  count DESC
