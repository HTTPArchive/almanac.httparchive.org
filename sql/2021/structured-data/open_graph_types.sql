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
    _TABLE_SUFFIX AS client,
    url,
    getOpenGraphTypes(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS open_graph_types
  FROM
    `httparchive.pages.2021_07_01_*`
),

page_totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
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
