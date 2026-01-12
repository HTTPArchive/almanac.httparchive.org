#standardSQL
# Top manifest categories
CREATE TEMPORARY FUNCTION getCategories(manifest JSON)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = Object.values(manifest)[0];
  var categories = $.categories;
  if (typeof categories == 'string') {
    return [categories];
  }
  return categories;
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

manifests_categories AS (
  SELECT
    'All Sites' AS type,
    client,
    category,
    COUNT(DISTINCT page) AS freq,
    total,
    COUNT(DISTINCT page) / total AS pct,
    COUNTIF(JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true') AS pwa_freq,
    pwa_total,
    COUNTIF(JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true') / pwa_total AS pwa_pct
  FROM
    `httparchive.crawl.pages`,
    UNNEST(getCategories(custom_metrics.other.pwa.manifests)) AS category
  JOIN
    totals
  USING (client)
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    TO_JSON_STRING(custom_metrics.other.pwa.manifests) NOT IN ('[]', '{}', 'null')
  GROUP BY
    client,
    category,
    total,
    pwa_total
  HAVING
    category IS NOT NULL
  ORDER BY
    type DESC,
    freq / total DESC,
    category,
    client
)

SELECT
  'PWA Sites' AS type,
  client,
  category,
  pwa_freq AS freq,
  pwa_total AS total,
  pwa_pct AS pct
FROM
  manifests_categories
UNION ALL
SELECT
  'All Sites' AS type,
  client,
  category,
  freq,
  total,
  pct
FROM
  manifests_categories
ORDER BY
  type DESC,
  pct DESC,
  category,
  client
