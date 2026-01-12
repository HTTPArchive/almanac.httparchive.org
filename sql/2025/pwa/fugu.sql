#standardSQL
CREATE TEMP FUNCTION getFuguAPIsFromOther(other_json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
try {
  const other = JSON.parse(other_json);
  const fugu = other && typeof other === 'object' ? other['fugu-apis'] : null;
  if (!fugu || typeof fugu !== 'object') return [];
  return Object.keys(fugu);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  fuguAPI,
  COUNT(DISTINCT page) AS pages,
  total,
  COUNT(DISTINCT page) / total AS pct,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT page LIMIT 50), ' ') AS sample_urls
FROM
  `httparchive.crawl.pages`
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = DATE '2025-06-01' AND is_root_page
  GROUP BY
    client
)
USING (client),
  UNNEST(
    getFuguAPIsFromOther(TO_JSON_STRING(custom_metrics.other))
  ) AS fuguAPI
WHERE
  date = DATE '2025-06-01' AND is_root_page
GROUP BY
  fuguAPI,
  client,
  total
HAVING
  COUNT(DISTINCT page) >= 10
ORDER BY
  pct DESC,
  client;
