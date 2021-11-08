#standardSQL
# % of pages using each link protocol
CREATE TEMPORARY FUNCTION getUsedProtocols(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return Object.keys(almanac.link_protocols_used);
} catch (e) {
  return [];
}
''';
SELECT
  _TABLE_SUFFIX AS client,
  total_pages,
  protocol,
  COUNT(0) AS total_pages_using,
  COUNT(0) / total_pages AS pct_pages_using
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getUsedProtocols(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS protocol
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
GROUP BY
  client,
  protocol,
  total_pages
HAVING
  total_pages_using >= 100
ORDER BY
  pct_pages_using DESC
