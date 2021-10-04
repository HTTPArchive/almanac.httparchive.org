# standardSQL
  # Count RDFa Prefixes
CREATE TEMP FUNCTION
  getRDFaPrefixes(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
  try {
    rendered = JSON.parse(rendered);
    return rendered.rdfa_prefixes.map(prefix => prefix.toLowerCase());
  } catch (e) {
      return [];
  }
""";
WITH
  rendered_data AS (
  SELECT
    getRDFaPrefixes(rendered) AS rdfaPrefixes
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered
    FROM
      `httparchive.pages.2021_07_01_*`))
SELECT
  rdfaPrefix,
  COUNT(rdfaPrefix) AS count
FROM
  rendered_data,
  UNNEST(rdfaPrefixes) AS rdfaPrefix
GROUP BY
  rdfaPrefix
ORDER BY
  count DESC;
