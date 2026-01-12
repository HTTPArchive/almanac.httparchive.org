#standardSQL
# Top manifest orientations

CREATE TEMP FUNCTION getOrientation(manifest STRING) RETURNS STRING LANGUAGE js AS '''
try {
  var $ = Object.values(JSON.parse(manifest))[0];
  if (!('orientation' in $)) {
    return '(not set)';
  }
  return $.orientation;
} catch {
  return '(not set)'
}
''';

SELECT
  'PWA Sites' AS type,
  client,
  getOrientation(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests'))) AS orientation,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.pages`
WHERE
  date = DATE '2025-06-01' AND
  is_root_page AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests')) NOT IN ('[]','{}','null') AND
  JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
GROUP BY
  type,
  client,
  orientation
UNION ALL
SELECT
  'All Sites' AS type,
  client,
  getOrientation(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests'))) AS orientation,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.pages`
WHERE
  date = DATE '2025-06-01' AND
  is_root_page AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests')) NOT IN ('[]','{}','null')
GROUP BY
  type,
  client,
  orientation
ORDER BY
  type DESC,
  freq / total DESC,
  orientation,
  client
