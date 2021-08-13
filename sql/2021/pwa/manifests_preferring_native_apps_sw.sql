#standardSQL
# % manifests preferring native apps for service worker pages
# Question: Below only uses first manifest - what should we do it more than one is defined?

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
  _TABLE_SUFFIX AS client,
  prefersNative(JSON_EXTRACT(payload, '$._pwa.manifests')) AS prefersNative,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2021_07_01_*`
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa. serviceWorkerHeuristic') = "true" AND
  prefersNative(JSON_EXTRACT(payload, '$._pwa.manifests')) IS NOT NULL
GROUP BY
  client,
  prefersNative
ORDER BY
  freq / total DESC,
  prefersNative,
  client
