#standardSQL
# Top manifest properties

CREATE TEMP FUNCTION getManifestProps(manifest JSON)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var manifestJSON = Object.values(manifest)[0];
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
    client,
    COUNT(0) AS total,
    COUNTIF(JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true') AS pwa_total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    TO_JSON_STRING(custom_metrics.other.pwa.manifests) NOT IN ('[]', '{}', 'null')
  GROUP BY
    client
),

manifests_properties AS (
  SELECT
    'All Sites' AS type,
    client,
    property,
    COUNT(DISTINCT page) AS freq,
    total,
    COUNT(DISTINCT page) / total AS pct,
    COUNTIF(JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true') AS pwa_freq,
    pwa_total,
    COUNTIF(JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true') / pwa_total AS pwa_pct
  FROM
    `httparchive.crawl.pages`,
    UNNEST(getManifestProps(custom_metrics.other.pwa.manifests)) AS property
  JOIN
    totals
  USING (client)
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    TO_JSON_STRING(custom_metrics.other.pwa.manifests) NOT IN ('[]', '{}', 'null')
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
LIMIT 1000
