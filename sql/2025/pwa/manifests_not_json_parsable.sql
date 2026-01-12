#standardSQL
# Manifests that are not JSON parsable for service worker pages and all pages

CREATE TEMP FUNCTION canParseManifest(manifest STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var manifestJSON = Object.values(JSON.parse(manifest))[0];
  if (typeof manifestJSON === 'string' && manifestJSON.trim() != '') {
    return false;
  }
  if (typeof manifestJSON === 'string' && manifestJSON.trim() === '') {
    return null;
  }
  return true;
} catch {
  return false;
}
''';

SELECT
  'PWA Pages' AS type,
  client,
  canParseManifest(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests'))) AS can_parse,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.pages`
WHERE
  date = DATE '2025-06-01' AND
  is_root_page AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests')) NOT IN ('[]', '{}', 'null') AND
  JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
GROUP BY
  client,
  can_parse
UNION ALL
SELECT
  'All Pages' AS type,
  client,
  canParseManifest(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests'))) AS can_parse,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.pages`
WHERE
  date = DATE '2025-06-01' AND
  is_root_page
GROUP BY
  client,
  can_parse
ORDER BY
  type DESC,
  freq / total DESC,
  can_parse,
  client
