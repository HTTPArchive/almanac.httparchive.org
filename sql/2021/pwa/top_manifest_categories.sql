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
SELECT
  'PWA Sites' AS type,
  _TABLE_SUFFIX AS client,
  category,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getCategories(JSON_EXTRACT(payload, '$._pwa.manifests'))) AS category
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
GROUP BY
  client,
  category,
  total
HAVING
  category IS NOT NULL
UNION ALL
SELECT
  'All Sites' AS type,
  _TABLE_SUFFIX AS client,
  category,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getCategories(JSON_EXTRACT(payload, '$._pwa.manifests'))) AS category
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
GROUP BY
  client,
  category,
  total
HAVING
  category IS NOT NULL
ORDER BY
  type DESC,
  freq / total DESC,
  category,
  client
