# standardSQL
  # Count Dublin Core types
CREATE TEMP FUNCTION
  getDublinCoreTypes(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
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
    getDublinCoreTypes(rendered) AS dublin_core_types
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  dublin_core_type,
  COUNT(dublin_core_type) AS count
FROM
  rendered_data,
  UNNEST(dublin_core_types) AS dublin_core_type
GROUP BY
  dublin_core_type
ORDER BY
  count DESC
