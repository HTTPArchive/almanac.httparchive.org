#standardSQL
# Top manifest icon sizes
CREATE TEMPORARY FUNCTION getIconSizes(manifest STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = Object.values(JSON.parse(manifest))[0];
  return $.icons.map(icon => icon.sizes);
} catch (e) {
  return null;
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

manifests_icon_sizes AS (
  SELECT
    'All Sites' AS type,
    _TABLE_SUFFIX AS client,
    size,
    COUNT(DISTINCT url) AS freq,
    total,
    COUNT(DISTINCT url) / total AS pct,
    COUNTIF(JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true") AS pwa_freq,
    pwa_total,
    COUNTIF(JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true") / pwa_total AS pwa_pct
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getIconSizes(JSON_EXTRACT(payload, '$._pwa.manifests'))) AS size
  JOIN
    totals
  USING (_TABLE_SUFFIX)
  WHERE
    JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
  GROUP BY
    client,
    size,
    total,
    pwa_total
  HAVING
    size IS NOT NULL
  ORDER BY
    type DESC,
    freq / total DESC,
    size,
    client
)

SELECT
  'PWA Sites' AS type,
  client,
  size,
  pwa_freq AS freq,
  pwa_total AS total,
  pwa_pct AS pct
FROM
  manifests_icon_sizes
WHERE
  size IS NOT NULL AND
  freq > 100
UNION ALL
SELECT
  'All Sites' AS type,
  client,
  size,
  freq,
  total,
  pct
FROM
  manifests_icon_sizes
WHERE
  size IS NOT NULL AND
  freq > 100
ORDER BY
  type DESC,
  pct DESC,
  size,
  client
