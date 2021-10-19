# standardSQL
# Count Twitter types
CREATE TEMP FUNCTION getTwitterTypes(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
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
    getTwitterTypes(rendered) AS twitter_types,
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
  twitter_type,
  COUNT(twitter_type) AS count,
  SUM(COUNT(twitter_type)) OVER (PARTITION BY client) AS total,
  COUNT(twitter_type) / SUM(COUNT(twitter_type)) OVER (PARTITION BY client) AS pct,
  client
FROM
  rendered_data,
  UNNEST(twitter_types) AS twitter_type
GROUP BY
  twitter_type,
  client
ORDER BY
  count DESC
