#standardSQL
# % manifests with narrow platform screenshots for service worker pages and all pages

CREATE TEMP FUNCTION hasScreenshotsPlatformNarrow(manifest STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var manifest = Object.values(JSON.parse(manifest))[0];
  var screenshots = manifest.screenshots;
  var check = screenshots.some(obj => obj.platform == 'narrow');
  return check;
} catch (e) {
  return null;
}
''';

SELECT
  'PWA Pages' AS type,
  _TABLE_SUFFIX AS client,
  hasScreenshotsPlatformNarrow(JSON_EXTRACT(payload, '$._pwa.manifests')) AS platformNarrow,
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
  platformNarrow
