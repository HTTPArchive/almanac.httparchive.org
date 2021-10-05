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
    getDublinCoreTypes(rendered) AS dublinCoreTypes
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  dublinCoreType,
  COUNT(dublinCoreType) AS count
FROM
  rendered_data,
  UNNEST(dublinCoreTypes) AS dublinCoreType
GROUP BY
  dublinCoreType
ORDER BY
  count DESC;
