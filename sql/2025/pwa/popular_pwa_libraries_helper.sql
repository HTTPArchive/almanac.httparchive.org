#standardSQL
# Use this to find popular library imports for popular_pwa_libraries.sql (2025)
# Only crawl/custom_metrics updates; logic identical to 2022

CREATE TEMPORARY FUNCTION getSWLibraries(importScriptsInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const obj = JSON.parse(importScriptsInfo || '{}');
  const keys = Object.keys(obj);
  const values = Object.values(obj);
  const libs = keys.concat(values).map(s => (s || '').toString().trim().replace(/'/g, ''));
  return Array.from(new Set(libs));
} catch (e) {
  return [];
}
''';

SELECT
  client,
  script,
  COUNT(DISTINCT page) AS freq
FROM
  `httparchive.crawl.pages`,
  UNNEST(getSWLibraries(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.importScriptsInfo')))) AS script
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.importScriptsInfo')) NOT IN ('[]', '{}', 'null') AND
  JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true' AND
  LOWER(script) NOT LIKE '%workbox%' AND
  LOWER(script) NOT LIKE '%sw-toolbox%' AND
  LOWER(script) NOT LIKE '%firebase%' AND
  LOWER(script) NOT LIKE '%onesignalsdk%' AND
  LOWER(script) NOT LIKE '%najva%' AND
  LOWER(script) NOT LIKE '%upush%' AND
  LOWER(script) NOT LIKE '%cache-polyfill.js%' AND
  LOWER(script) NOT LIKE '%analytics-helper.js%' AND
  LOWER(script) NOT LIKE '%recaptcha%' AND
  LOWER(script) NOT LIKE '%pwabuilder%'
GROUP BY
  client,
  script
ORDER BY
  freq DESC;
