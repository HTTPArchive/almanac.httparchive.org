#standardSQL
# Workbox methods (2025)

CREATE TEMPORARY FUNCTION getWorkboxMethods(workboxInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var workboxPackageMethods = Object.values(JSON.parse(workboxInfo || '{}'));
  if (typeof workboxPackageMethods == 'string') {
    workboxPackageMethods = [workboxPackageMethods];
  }
  var workboxMethods = [];
  for (var i = 0; i < workboxPackageMethods.length; i++) {
    var workboxItems = workboxPackageMethods[i].toString().trim().split(',');
    for (var j = 0; j < workboxItems.length; j++) {
      if (workboxItems[j].indexOf(':') == -1) {
        if (workboxItems[j].trim().startsWith('workbox.')) {
          workboxMethods.push(workboxItems[j].trim().substring(8));
        }
      }
    }
  }
  return Array.from(new Set(workboxMethods));
} catch (e) { return [] }
''';

SELECT
  client,
  workbox_method,
  REGEXP_EXTRACT(workbox_method, r'^([^.]+)') AS module_only,
  REGEXP_EXTRACT(workbox_method, r'^[^.]+\.([^.]+)') AS method_only,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM `httparchive.crawl.pages`,
  UNNEST(getWorkboxMethods(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.workboxInfo')))) AS workbox_method
JOIN (
  SELECT client, COUNT(0) AS total
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-06-01' AND is_root_page
    AND JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
  GROUP BY client
) totals USING (client)
WHERE date = DATE '2025-06-01' AND is_root_page
  AND TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.workboxInfo')) NOT IN ('[]','{}','null')
  AND JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
GROUP BY client, workbox_method, total
ORDER BY pct DESC, client;


