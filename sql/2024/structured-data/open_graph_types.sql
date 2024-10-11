# standardSQL
# open_graph_types.sql
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
    client,
    root_page AS url,
    getOpenGraphTypes(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS open_graph_types
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
),

page_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_pages
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
)

SELECT
  client,
  open_graph_type,
  COUNT(open_graph_type) AS freq_open_graph_type,
  SUM(COUNT(open_graph_type)) OVER (PARTITION BY client) AS total_open_graph_types,
  COUNT(open_graph_type) / SUM(COUNT(open_graph_type)) OVER (PARTITION BY client) AS pct_open_graph_types,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(open_graph_types) AS open_graph_type
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  open_graph_type,
  total_pages
ORDER BY
  pct_open_graph_types DESC,
  client
