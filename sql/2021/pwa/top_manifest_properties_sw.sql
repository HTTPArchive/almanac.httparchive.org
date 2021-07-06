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
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0)/SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.sample_data.pages_*`,
  --`httparchive.pages.2021_07_01_*`,
  UNNEST(getManifestProps(JSON_EXTRACT(payload, '$._pwa.manifests') )) AS property
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkers') != "[]"
GROUP BY
  client,
  property
HAVING
  property IS NOT NULL

ORDER BY
  freq / total DESC,
  property,
  client

