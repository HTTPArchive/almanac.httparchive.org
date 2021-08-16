# standardSQL
# Usage of client hint directives
CREATE TEMPORARY FUNCTION getClientHints(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS """
try {
  const $ = JSON.parse(payload);
  const headers = $.response.headers;

  const client_hints = new Set();
  for (const header of headers) {
    if (header.name.toLowerCase() !== 'accept-ch') {
      continue;
    }

    client_hints.push(...header.value.split(/\s*,\s*));
  }

  return Array.from(client_hints);
} catch (e) {
  return [];
}
""";
SELECT
  _TABLE_SUFFIX AS client,
  total_sites,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total_sites_using_ch,
  hint,
  COUNT(0) AS total_sites_using,
  COUNT(0) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS pct_ch_sites_using,
  COUNT(0) / total_sites AS pct_sites
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getClientHints(payload)) AS hint
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_sites
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
GROUP BY
  client,
  hint,
  total_sites
HAVING
  total_sites_using >= 100
ORDER BY
  pct_sites DESC
