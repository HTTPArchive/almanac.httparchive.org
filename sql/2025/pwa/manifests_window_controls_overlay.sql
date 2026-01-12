#standardSQL
# % manifests with window controls overlay display override for service worker pages and all pages

CREATE TEMP FUNCTION hasWindowControlsOverlay(manifest STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var manifest = Object.values(JSON.parse(manifest))[0];
  var display_override = manifest.display_override;
  var check = display_override.includes("window-controls-overlay");
  return check;
} catch (e) {
  return null;
}
''';

SELECT
  'PWA Pages' AS type,
  client,
  hasWindowControlsOverlay(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests'))) AS hasWindowControlsOverlay,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM `httparchive.crawl.pages`
WHERE date = DATE '2025-06-01' AND is_root_page
  AND TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests')) NOT IN ('[]','{}','null')
  AND JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
GROUP BY
  client,
  hasWindowControlsOverlay
