#standardSQL
# % manifests with shortcuts for service worker pages and all pages

CREATE TEMP FUNCTION hasShortcuts(manifest STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = Object.values(JSON.parse(manifest))[0];
  return $.hasOwnProperty('shortcuts') && $.shortcuts.length > 0;
} catch (e) {
  return null;
}
''';

SELECT
  'PWA Pages' AS type,
  _TABLE_SUFFIX AS client,
  hasShortcuts(JSON_EXTRACT(payload, '$._pwa.manifests')) AS hasShortcuts,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2022_06_01_*`
WHERE
  JSON_EXTRACT(payload, '$._pwa.manifests') != '[]' AND JSON_EXTRACT(payload, '$._pwa.manifests') != '{}' AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true'
GROUP BY
  client,
  hasShortcuts
