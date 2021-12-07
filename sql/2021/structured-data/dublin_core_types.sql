# standardSQL
# Count Dublin Core types
CREATE TEMP FUNCTION getDublinCoreTypes(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  try {
    rendered = JSON.parse(rendered);
    return rendered.dublin_core.map(dublin_core => dublin_core.name.toLowerCase());
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    getDublinCoreTypes(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS dublin_core_types
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
  dublin_core_type,
  COUNT(dublin_core_type) AS count,
  SUM(COUNT(dublin_core_type)) OVER (PARTITION BY client) AS freq_dublin_core,
  COUNT(dublin_core_type) / SUM(COUNT(dublin_core_type)) OVER (PARTITION BY client) AS pct_dublin_core,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(dublin_core_types) AS dublin_core_type
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  dublin_core_type,
  total_pages
ORDER BY
  pct_dublin_core DESC,
  client
