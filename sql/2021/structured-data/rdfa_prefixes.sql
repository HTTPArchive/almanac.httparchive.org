# standardSQL
  # Count RDFa Prefixes
CREATE TEMP FUNCTION
  getRDFaPrefixes(rendered STRING)
  RETURNS ARRAY<STRING>
  LANGUAGE js AS r"""
  try {
    rendered = JSON.parse(rendered);
    const prefixRegExp = new RegExp(/(?<ncname>[^:]*):\s+(?<uri>[^\s]*)\s*/gm)
    return rendered.rdfa_prefixes.map(prefix => {
      const matches = [...prefix.toLowerCase().trim().matchAll(prefixRegExp)];
      return matches.map(match => match.groups.uri);
    }).flat();
  } catch (e) {
    return [];
  }
""";
WITH
  rendered_data AS (
  SELECT
    getRDFaPrefixes(rendered) AS rdfa_prefixes,
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
  rdfa_prefix,
  COUNT(rdfa_prefix) AS count,
  client
FROM
  rendered_data,
  UNNEST(rdfa_prefixes) AS rdfa_prefix
GROUP BY
  rdfa_prefix,
  client
ORDER BY
  count DESC
