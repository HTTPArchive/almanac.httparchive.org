# standardSQL
# Count RDFa Type Ofs
CREATE TEMP FUNCTION getRDFaTypeOfs(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  try {
    rendered = JSON.parse(rendered);
    return rendered.rdfa_typeofs.map(typeOf => typeOf.toLowerCase().trim().split(/\s+/)).flat();
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    getRDFaTypeOfs(rendered) AS rdfa_type_ofs,
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
  rdfa_type_of,
  COUNT(rdfa_type_of) AS count,
  SUM(COUNT(rdfa_type_of)) OVER (PARTITION BY client) AS total,
  COUNT(rdfa_type_of) / SUM(COUNT(rdfa_type_of)) OVER (PARTITION BY client) AS pct,
  client
FROM
  rendered_data,
  UNNEST(rdfa_type_ofs) AS rdfa_type_of
GROUP BY
  rdfa_type_of,
  client
ORDER BY
  count DESC
