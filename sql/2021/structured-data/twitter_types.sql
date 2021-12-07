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
    _TABLE_SUFFIX AS client,
    url,
    getTwitterTypes(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS twitter_types
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
  twitter_type,
  COUNT(twitter_type) AS freq_twitter,
  SUM(COUNT(twitter_type)) OVER (PARTITION BY client) AS total_twitter,
  COUNT(twitter_type) / SUM(COUNT(twitter_type)) OVER (PARTITION BY client) AS pct_twitter,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(twitter_types) AS twitter_type
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  twitter_type,
  total_pages
ORDER BY
  pct_twitter DESC,
  client
