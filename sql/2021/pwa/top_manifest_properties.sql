#standardSQL
# Top manifest properties

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
  "PWA Sites" AS type,
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
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
GROUP BY
  client,
  property,
  total
HAVING
  property IS NOT NULL AND
  freq > 100
UNION ALL
SELECT
  "All Sites" AS type,
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
      JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
GROUP BY
  client,
  property,
  total
HAVING
  property IS NOT NULL AND
  freq > 1000
ORDER BY
  type DESC,
  freq / total DESC,
  property,
  client
