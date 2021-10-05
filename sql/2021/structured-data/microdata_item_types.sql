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
    getMicrodataItemTypes(rendered) AS microdataItemTypes
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  microdataItemType,
  COUNT(microdataItemType) AS count
FROM
  rendered_data,
  UNNEST(microdataItemTypes) AS microdataItemType
GROUP BY
  microdataItemType
ORDER BY
  count DESC;
