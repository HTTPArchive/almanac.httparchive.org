# standardSQL
  # Count RDFa Type Ofs
CREATE TEMP FUNCTION
  getRDFaTypeOfs(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
  try {
    rendered = JSON.parse(rendered);
    return rendered.rdfa_typeofs.map(typeOf => typeOf.toLowerCase());
  } catch (e) {
    return [];
  }
""";
WITH
  rendered_data AS (
  SELECT
    getRDFaTypeOfs(rendered) AS rdfaTypeOfs
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  rdfaTypeOf,
  COUNT(rdfaTypeOf) AS count
FROM
  rendered_data,
  UNNEST(rdfaTypeOfs) AS rdfaTypeOf
GROUP BY
  rdfaTypeOf
ORDER BY
  count DESC;
