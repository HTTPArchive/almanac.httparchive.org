#standardSQL
# Top manifest properties

CREATE TEMP FUNCTION getManifestProps(manifest STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var manifestJSON = Object.values(JSON.parse(manifest))[0];
  if (typeof manifestJSON === 'string') {
    return null;
  }
  return Object.keys(manifestJSON);
} catch {
  return null
}
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total,
    COUNTIF(JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true") AS pwa_total
  FROM
    `httparchive.pages.2021_07_01_*`
  WHERE
    JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
  GROUP BY
    _TABLE_SUFFIX
),

manifests_properties AS (
  SELECT
    'All Sites' AS type,
    _TABLE_SUFFIX AS client,
    property,
    COUNT(DISTINCT url) AS freq,
    total,
    COUNT(DISTINCT url) / total AS pct,
    COUNTIF(JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true") AS pwa_freq,
    pwa_total,
    COUNTIF(JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true") / pwa_total AS pwa_pct
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getManifestProps(JSON_EXTRACT(payload, '$._pwa.manifests'))) AS property
  JOIN
    totals
  USING (_TABLE_SUFFIX)
  WHERE
    JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
  GROUP BY
    client,
    property,
    total,
    pwa_total
  HAVING
    property IS NOT NULL
  ORDER BY
    type DESC,
    freq / total DESC,
    property,
    client
)

SELECT
  'PWA Sites' AS type,
  client,
  property,
  pwa_freq AS freq,
  pwa_total AS total,
  pwa_pct AS pct
FROM
  manifests_properties
WHERE
  property IS NOT NULL AND
  freq > 100
UNION ALL
SELECT
  'All Sites' AS type,
  client,
  property,
  freq,
  total,
  pct
FROM
  manifests_properties
WHERE
  property IS NOT NULL AND
  freq > 100
ORDER BY
  type DESC,
  pct DESC,
  property,
  client
