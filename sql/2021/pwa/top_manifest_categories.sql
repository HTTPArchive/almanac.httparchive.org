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
  _TABLE_SUFFIX AS client,
  category,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0)/SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct,
FROM
  `httparchive.sample_data.pages_*`,
  --`httparchive.pages.2021_07_01_*`,
  UNNEST(getCategories(JSON_EXTRACT(payload, '$._pwa.manifests'))) AS category
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
GROUP BY
  client,
  category
HAVING
  category IS NOT NULL
ORDER BY
  freq / total DESC,
  category,
  client
LIMIT 500
