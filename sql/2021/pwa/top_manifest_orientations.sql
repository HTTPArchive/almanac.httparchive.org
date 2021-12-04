#standardSQL
# Top manifest orientations

CREATE TEMP FUNCTION getOrientation(manifest STRING) RETURNS STRING LANGUAGE js AS '''
try {
  var $ = Object.values(JSON.parse(manifest))[0];
  if (!('orientation' in $)) {
    return '(not set)';
  }
  return $.orientation;
} catch {
  return '(not set)'
}
''';

SELECT
  "PWA Sites" AS type,
  _TABLE_SUFFIX AS client,
  getOrientation(JSON_EXTRACT(payload, '$._pwa.manifests')) AS orientation,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2021_07_01_*`
WHERE
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
GROUP BY
  type,
  client,
  orientation
UNION ALL
SELECT
  "All Sites" AS type,
  _TABLE_SUFFIX AS client,
  getOrientation(JSON_EXTRACT(payload, '$._pwa.manifests')) AS orientation,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2021_07_01_*`
WHERE
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
GROUP BY
  type,
  client,
  orientation
ORDER BY
  type DESC,
  freq / total DESC,
  orientation,
  client
