# standardSQL
  # Count Facebook types
CREATE TEMP FUNCTION
  getFacebookTypes(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
  try {
    rendered = JSON.parse(rendered);
    return rendered.facebook.map(facebook => facebook.property.toLowerCase());
  } catch (e) {
    return [];
  }
""";
WITH
  rendered_data AS (
  SELECT
    getFacebookTypes(rendered) AS facebookTypes
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  facebookType,
  COUNT(facebookType) AS count
FROM
  rendered_data,
  UNNEST(facebookTypes) AS facebookType
GROUP BY
  facebookType
ORDER BY
  count DESC;
