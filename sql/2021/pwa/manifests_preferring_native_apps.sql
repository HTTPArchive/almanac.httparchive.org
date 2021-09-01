#standardSQL
# % manifests preferring native apps for service worker pages and all pages

CREATE TEMP FUNCTION prefersNative(manifest STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = Object.values(JSON.parse(manifest))[0];
  return $.prefer_related_applications == true && $.related_applications.length > 0;
} catch (e) {
  return null;
}
''';

SELECT
  'PWA Pages' AS type,
  _TABLE_SUFFIX AS client,
  prefersNative(JSON_EXTRACT(payload, '$._pwa.manifests')) AS prefersNative,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2021_07_01_*`
WHERE
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
GROUP BY
  client,
  prefersNative
UNION ALL
SELECT
  'All Pages' AS type,
  _TABLE_SUFFIX AS client,
  prefersNative(JSON_EXTRACT(payload, '$._pwa.manifests')) AS prefersNative,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2021_07_01_*`
GROUP BY
  client,
  prefersNative
ORDER BY
  type DESC,
  freq / total DESC,
  prefersNative,
  client
