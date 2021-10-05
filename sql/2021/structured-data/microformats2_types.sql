# standardSQL
  # Count microformats2 types
CREATE TEMP FUNCTION
  getMicroformats2Types(rendered STRING)
  RETURNS ARRAY<STRUCT<name STRING, count NUMERIC>>
  LANGUAGE js AS r"""
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
    getMicroformats2Types(rendered) AS microformats2Types
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  microformats2Type.name AS microformats2Type,
  SUM(microformats2Type.count) AS count
FROM
  rendered_data,
  UNNEST(microformats2Types) AS microformats2Type
GROUP BY
  microformats2Type
ORDER BY
  count DESC;
