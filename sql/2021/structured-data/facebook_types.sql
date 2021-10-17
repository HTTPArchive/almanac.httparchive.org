# standardSQL
# Count Facebook types
CREATE TEMP FUNCTION getFacebookTypes(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
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
    getFacebookTypes(rendered) AS facebook_types,
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
  facebook_type,
  COUNT(facebook_type) AS count,
  SUM(COUNT(facebook_type)) OVER (PARTITION BY client) AS total,
  COUNT(facebook_type) / SUM(COUNT(facebook_type)) OVER (PARTITION BY client) AS pct,
  client
FROM
  rendered_data,
  UNNEST(facebook_types) AS facebook_type
GROUP BY
  facebook_type,
  client
ORDER BY
  count DESC
