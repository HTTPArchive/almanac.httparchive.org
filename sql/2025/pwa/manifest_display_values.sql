#standardSQL
# Top most used display values in manifest files

CREATE TEMP FUNCTION getDisplay(manifest JSON) RETURNS STRING LANGUAGE js AS '''
try {
  var $ = Object.values(manifest)[0];
  if (!('display' in $)) {
    return '(not set)';
  }
  return $.display;
} catch {
  return '(not set)'
}
''';

SELECT
  'PWA Sites' AS type,
  client,
  getDisplay(custom_metrics.other.pwa.manifests) AS display,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  TO_JSON_STRING(custom_metrics.other.pwa.manifests) NOT IN ('[]', '{}', 'null') AND
  JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true'
GROUP BY
  client,
  display
QUALIFY
  display IS NOT NULL AND
  freq > 100
UNION ALL
SELECT
  'All Sites' AS type,
  client,
  getDisplay(custom_metrics.other.pwa.manifests) AS display,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  TO_JSON_STRING(custom_metrics.other.pwa.manifests) NOT IN ('[]', '{}', 'null')
GROUP BY
  client,
  display
QUALIFY
  display IS NOT NULL AND
  freq > 100
ORDER BY
  type DESC,
  freq / total DESC,
  display,
  client
