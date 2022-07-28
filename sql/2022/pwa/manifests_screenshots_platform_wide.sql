#standardSQL
# % manifests with wide platform screenshots for service worker pages and all pages

CREATE TEMP FUNCTION hasScreenshotsPlatformWide(manifest STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var manifest = Object.values(JSON.parse(manifest))[0];
  var screenshots = manifest.screenshots;
  var check = screenshots.some(obj => obj.platform == 'wide');
  return check;
} catch (e) {
  return null;
}
''';

SELECT
  'PWA Pages' AS type,
  _TABLE_SUFFIX AS client,
  hasScreenshotsPlatformWide(JSON_EXTRACT(payload, '$._pwa.manifests')) AS platformWide,
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
  platformWide
