# standardSQL
# facebook_types.sql
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
    client,
    root_page AS url,
    getFacebookTypes(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS facebook_type
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
  facebook_type,
  COUNT(facebook_type) AS freq_facebook,
  SUM(COUNT(facebook_type)) OVER (PARTITION BY client) AS total_facebook,
  COUNT(facebook_type) / SUM(COUNT(facebook_type)) OVER (PARTITION BY client) AS pct_facebook,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(facebook_type) AS facebook_type
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  facebook_type,
  total_pages
ORDER BY
  freq_facebook DESC,
  client
