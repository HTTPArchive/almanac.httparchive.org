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
    getMicroformats2Types(rendered) AS microformats2_types,
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
  microformats2_type.name AS microformats2_type,
  SUM(microformats2_type.count) AS count,
  SUM(SUM(microformats2_type.count)) OVER (PARTITION BY client) AS total,
  SUM(microformats2_type.count) / SUM(SUM(microformats2_type.count)) OVER (PARTITION BY client) AS pct,
  client
FROM
  rendered_data,
  UNNEST(microformats2_types) AS microformats2_type
GROUP BY
  microformats2_type,
  client
ORDER BY
  count DESC
