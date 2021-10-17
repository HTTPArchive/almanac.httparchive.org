# standardSQL
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
    getClassicMicroformatsTypes(rendered) AS classic_microformats_types,
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
  classic_microformats_type.name AS classic_microformats_type,
  SUM(classic_microformats_type.count) AS count,
  SUM(SUM(classic_microformats_type.count)) OVER (PARTITION BY client) AS total,
  SUM(classic_microformats_type.count) / SUM(SUM(classic_microformats_type.count)) OVER (PARTITION BY client) AS pct,
  client
FROM
  rendered_data,
  UNNEST(classic_microformats_types) AS classic_microformats_type
GROUP BY
  classic_microformats_type,
  client
ORDER BY
  count DESC
