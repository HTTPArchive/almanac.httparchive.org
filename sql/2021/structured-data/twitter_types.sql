# standardSQL
  # Count Twitter types
CREATE TEMP FUNCTION
  getTwitterTypes(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
  try {
    rendered = JSON.parse(rendered);
    return rendered.twitter.map(twitter => twitter.name.toLowerCase());
  } catch (e) {
    return [];
  }
""";
WITH
  rendered_data AS (
  SELECT
    getTwitterTypes(rendered) AS twitterTypes
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  twitterType,
  COUNT(twitterType) AS count
FROM
  rendered_data,
  UNNEST(twitterTypes) AS twitterType
GROUP BY
  twitterType
ORDER BY
  count DESC;
