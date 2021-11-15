# standardSQL
# Count microformats2 types
CREATE TEMP FUNCTION getMicroformats2Types(rendered STRING)
RETURNS ARRAY<STRUCT<name STRING, count NUMERIC>>
LANGUAGE js AS """
  try {
    rendered = JSON.parse(rendered);
    return rendered.microformats2_types.map(microformat2_type => ({name: microformat2_type.name, count: microformat2_type.count}));
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    getMicroformats2Types(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS microformats2_types
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
  microformats2_type.name AS microformats2_type,
  SUM(microformats2_type.count) AS freq_microformats2,
  SUM(SUM(microformats2_type.count)) OVER (PARTITION BY client) AS total_microformats2_type,
  SUM(microformats2_type.count) / SUM(SUM(microformats2_type.count)) OVER (PARTITION BY client) AS pct_microformats2_type,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM
  rendered_data,
  UNNEST(microformats2_types) AS microformats2_type
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  microformats2_type,
  total_pages
ORDER BY
  pct_microformats2_type DESC,
  client
