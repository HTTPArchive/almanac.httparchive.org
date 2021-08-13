#standardSQL
# Top manifest properties
# Question: Below only uses first manifest - what should we do it more than one is defined?

CREATE TEMP FUNCTION getManifestProps(manifest STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  manifestJSON = Object.values(JSON.parse(manifest))[0];
  if (typeof manifestJSON === 'string') {
    return null;
  }
  return Object.keys(manifestJSON);
} catch {
  return null
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  property,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getManifestProps(JSON_EXTRACT(payload, '$._pwa.manifests') )) AS property
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
  property,
  total
HAVING
  property IS NOT NULL
ORDER BY
  freq / total DESC,
  property,
  client

