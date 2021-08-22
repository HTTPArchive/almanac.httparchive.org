# standardSQL
# Usage of client hint directives
CREATE TEMPORARY FUNCTION getClientHints(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS """
try {
  const parsed_headers = JSON.parse(headers);
  const matching_headers = parsed_headers.filter(h => h.name.toLowerCase() == headername.toLowerCase());
  if (matching_headers.length <= 0) {
    return [];
  }

  const unique_directives = new Set();
  for (const header of matching_headers) {
    const directives = header.value.split(/\\s*,\\s*/);
    for (const directive of directives) {
      unique_directives.add(directive);
    }
  }

  return Array.from(unique_directives);
} catch (e) {
  return [];
}
""";
SELECT
  client,
  total_sites,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total_sites_using_ch,

  ch_directive,
  COUNT(0) AS total_sites_using,
  COUNT(0) / total_sites AS pct_sites,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_ch_sites_using
FROM (
  SELECT
    page,
    client,
    ch_directive
  FROM
    `httparchive.almanac.requests`,
    UNNEST(getClientHints(JSON_EXTRACT(payload, '$.response.headers'))) AS ch_directive
  WHERE
    date = "2021-07-01" AND
    firstHtml
)
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_sites
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY _TABLE_SUFFIX
)
USING (client)
GROUP BY
  client,
  ch_directive,
  total_sites
HAVING
  total_sites_using >= 100
ORDER BY
  pct_sites DESC
