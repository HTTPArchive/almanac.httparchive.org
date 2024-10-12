# standardSQL
# classic_microformats_types.sql
# Count Classic Microformats types

CREATE TEMP FUNCTION getClassicMicroformatsTypes(rendered STRING)
RETURNS ARRAY<STRUCT<name STRING, count NUMERIC>>
LANGUAGE js AS """
  try {
    rendered = JSON.parse(rendered);
    return rendered.microformats_classic_types.map(microformats_classic_type => ({name: microformats_classic_type.name, count: microformats_classic_type.count}));
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    client,
    root_page AS url,
    getClassicMicroformatsTypes(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS classic_microformats_types
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
  classic_microformats_type.name AS classic_microformats_type,
  SUM(classic_microformats_type.count) AS freq_microformat,
  SUM(SUM(classic_microformats_type.count)) OVER (PARTITION BY client) AS total_microformat,
  SUM(classic_microformats_type.count) / SUM(SUM(classic_microformats_type.count)) OVER (PARTITION BY client) AS pct_microformat,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(classic_microformats_types) AS classic_microformats_type
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  classic_microformats_type,
  total_pages
ORDER BY
  freq_microformat DESC,
  client
