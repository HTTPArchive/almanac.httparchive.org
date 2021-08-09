#standardSQL
# Top manifest icon sizes for service worker controlled pages
CREATE TEMPORARY FUNCTION getIconSizes(manifest STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = Object.values(JSON.parse(manifest))[0];
  return $.icons.map(icon => icon.sizes);
} catch (e) {
  return null;
}
''';
SELECT
  _TABLE_SUFFIX AS client,
  size,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.sample_data.pages_*`,
  --`httparchive.pages.2021_07_01_*`,
  UNNEST(getIconSizes(JSON_EXTRACT(payload, '$._pwa.manifests'))) AS size
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkers') != "[]"
GROUP BY
  client,
  size
HAVING
  size IS NOT NULL
ORDER BY
  freq / total DESC,
  size,
  client
LIMIT 500
