# standardSQL
  # Count Open Graph types
CREATE TEMP FUNCTION
  getOpenGraphTypes(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
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
    getOpenGraphTypes(rendered) AS open_graph_types
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  open_graph_type,
  COUNT(open_graph_type) AS count
FROM
  rendered_data,
  UNNEST(open_graph_types) AS open_graph_type
GROUP BY
  open_graph_type
ORDER BY
  count DESC
