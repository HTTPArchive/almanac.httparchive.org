# standardSQL
  # Count Microdata item types
CREATE TEMP FUNCTION
  getMicrodataItemTypes(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
  try {
    rendered = JSON.parse(rendered);
    return rendered.microdata_itemtypes.map(itemType => itemType.toLowerCase());
  } catch (e) {
    return [];
  }
""";
WITH
  rendered_data AS (
  SELECT
    getMicrodataItemTypes(rendered) AS microdata_item_types,
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
  microdata_item_type,
  COUNT(microdata_item_type) AS count,
  client
FROM
  rendered_data,
  UNNEST(microdata_item_types) AS microdata_item_type
GROUP BY
  microdata_item_type,
  client
ORDER BY
  count DESC
