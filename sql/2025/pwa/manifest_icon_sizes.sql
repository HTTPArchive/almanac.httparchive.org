#standardSQL
# Top manifest icon sizes
CREATE TEMPORARY FUNCTION getIconSizes(manifest JSON)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = Object.values(manifest)[0];
  return $.icons.map(icon => icon.sizes);
} catch (e) {
  return null;
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

manifests_icon_sizes AS (
  SELECT
    'All Sites' AS type,
    client,
    size,
    COUNT(DISTINCT page) AS freq,
    total,
    COUNT(DISTINCT page) / total AS pct,
    COUNTIF(JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true') AS pwa_freq,
    pwa_total,
    COUNTIF(JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true') / pwa_total AS pwa_pct
  FROM
    `httparchive.crawl.pages`,
    UNNEST(getIconSizes(custom_metrics.other.pwa.manifests)) AS size
  JOIN
    totals
  USING (client)
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    TO_JSON_STRING(custom_metrics.other.pwa.manifests) NOT IN ('[]', '{}', 'null')
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
