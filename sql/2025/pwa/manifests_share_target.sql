#standardSQL
# % manifests with web share target for service worker pages and all pages

CREATE TEMP FUNCTION hasShareTarget(manifest JSON)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = Object.values(manifest)[0];
  return $.hasOwnProperty('share_target') && $.share_target != {};
} catch (e) {
  return null;
}
''';

SELECT
  'PWA Pages' AS type,
  client,
  hasShareTarget(custom_metrics.other.pwa.manifests) AS hasShareTarget,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  TO_JSON_STRING(custom_metrics.other.pwa.manifests) NOT IN ('[]', '{}', 'null') AND
  JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true'
GROUP BY
  client,
  hasShareTarget
ORDER BY
  client,
  hasShareTarget
