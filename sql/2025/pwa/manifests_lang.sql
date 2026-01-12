#standardSQL
# % manifests with language for service worker pages and all pages

DECLARE run_date DATE DEFAULT '2025-07-01';

CREATE TEMP FUNCTION hasLang(manifest JSON)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = Object.values(manifest)[0];
  return $.hasOwnProperty('lang') && $.lang != '';
} catch (e) {
  return null;
}
''';

SELECT
  'PWA Pages' AS type,
  client,
  hasLang(custom_metrics.other.pwa.manifests) AS hasLang,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.pages`
WHERE date = run_date AND
  is_root_page AND
  TO_JSON_STRING(custom_metrics.other.pwa.manifests) NOT IN ('[]', '{}', 'null') AND
  JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true'
GROUP BY
  client,
  hasLang
ORDER BY
  client,
  hasLang
