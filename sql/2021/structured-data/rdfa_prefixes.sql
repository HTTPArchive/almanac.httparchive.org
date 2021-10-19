# standardSQL
# Count RDFa Prefixes
CREATE TEMP FUNCTION getRDFaPrefixes(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
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
  SUM(COUNT(rdfa_prefix)) OVER (PARTITION BY client) AS total,
  COUNT(rdfa_prefix) / SUM(COUNT(rdfa_prefix)) OVER (PARTITION BY client) AS pct,
  client
FROM (
  SELECT
    -- Removes the protocol and any subdomains from the URL.
    -- e.g. "https://my.example.com/pathname" becomes "example.com/pathname"
    -- This is done to normalize the URL a bit before counting.
    CONCAT(NET.REG_DOMAIN(rdfa_prefix), SPLIT(rdfa_prefix, NET.REG_DOMAIN(rdfa_prefix))[SAFE_OFFSET(1)]) AS rdfa_prefix,
    client
  FROM
    rendered_data,
    UNNEST(rdfa_prefixes) AS rdfa_prefix
)
GROUP BY
  rdfa_prefix,
  client
ORDER BY
  count DESC
