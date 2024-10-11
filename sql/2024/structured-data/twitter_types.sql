# standardSQL
# twitter_types.sql
# Count X (former Twitter) types
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
    client,
    root_page AS url,
    getTwitterTypes(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS twitter_types
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
),

page_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_pages
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
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
