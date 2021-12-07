#standardSQL
# Top manifest categories
CREATE TEMPORARY FUNCTION getCategories(manifest STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = Object.values(JSON.parse(manifest))[0];
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

manifests_categories AS (
  SELECT
    'All Sites' AS type,
    _TABLE_SUFFIX AS client,
    category,
    COUNT(DISTINCT url) AS freq,
    total,
    COUNT(DISTINCT url) / total AS pct,
    COUNTIF(JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true") AS pwa_freq,
    pwa_total,
    COUNTIF(JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true") / pwa_total AS pwa_pct
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getCategories(JSON_EXTRACT(payload, '$._pwa.manifests'))) AS category
  JOIN
    totals
  USING (_TABLE_SUFFIX)
  WHERE
    JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
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
