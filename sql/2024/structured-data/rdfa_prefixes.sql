# standardSQL
# rdfa_prefixes.sql
# Count RDFa Prefixes
CREATE TEMP FUNCTION getRDFaPrefixes(rendered STRING)
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
    client,
    root_page AS url,
    getRDFaPrefixes(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS rdfa_prefixes
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
  rdfa_prefix,
  COUNT(rdfa_prefix) AS freq_rdfa,
  SUM(COUNT(rdfa_prefix)) OVER (PARTITION BY client) AS total_rdfa,
  COUNT(rdfa_prefix) / SUM(COUNT(rdfa_prefix)) OVER (PARTITION BY client) AS pct_rdfa,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM (
  SELECT
    client,
    url,
    -- Removes the protocol and any subdomains from the URL.
    -- e.g. "https://my.example.com/pathname" becomes "example.com/pathname"
    -- This is done to normalize the URL a bit before counting.
    CONCAT(NET.REG_DOMAIN(rdfa_prefix), SPLIT(rdfa_prefix, NET.REG_DOMAIN(rdfa_prefix))[SAFE_OFFSET(1)]) AS rdfa_prefix
  FROM
    rendered_data,
    UNNEST(rdfa_prefixes) AS rdfa_prefix
)
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  rdfa_prefix,
  total_pages
ORDER BY
  pct_rdfa DESC,
  client
