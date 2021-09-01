#standardSQL
# Top most used display values in manifest files

CREATE TEMP FUNCTION getDisplay(manifest STRING) RETURNS STRING LANGUAGE js AS '''
try {
  var $ = Object.values(JSON.parse(manifest))[0];
  if (!('display' in $)) {
    return '(not set)';
  }
  return $.display;
} catch {
  return '(not set)'
}
''';

SELECT
  "PWA Sites" AS type,
  _TABLE_SUFFIX AS client,
  getDisplay(JSON_EXTRACT(payload, '$._pwa.manifests')) AS display,
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
  display
QUALIFY
  display IS NOT NULL AND
  freq > 100
UNION ALL
SELECT
  "All Sites" AS type,
  _TABLE_SUFFIX AS client,
  getDisplay(JSON_EXTRACT(payload, '$._pwa.manifests')) AS display,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2021_07_01_*`
WHERE
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
GROUP BY
  client,
  display
QUALIFY
  display IS NOT NULL AND
  freq > 100
ORDER BY
  type DESC,
  freq / total DESC,
  display,
  client
