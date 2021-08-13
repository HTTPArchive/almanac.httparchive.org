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
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getIconSizes(JSON_EXTRACT(payload, '$._pwa.manifests'))) AS size
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa') != "[]" AND
      JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
      JSON_EXTRACT(payload, '$._pwa. serviceWorkerHeuristics') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa. serviceWorkerHeuristics') = "true"
GROUP BY
  client,
  size,
  total
HAVING
  size IS NOT NULL
ORDER BY
  freq / total DESC,
  size,
  client
LIMIT 500
