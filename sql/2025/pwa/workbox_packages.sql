#standardSQL
# Workbox package and methods (2025)

CREATE TEMPORARY FUNCTION getWorkboxPackages(workboxInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var workboxPackageMethods = Object.values(JSON.parse(workboxInfo || '{}'));
  if (typeof workboxPackageMethods == 'string') {
    workboxPackageMethods = [workboxPackageMethods];
  }
  var workboxPackages = [];
  for (var i = 0; i < workboxPackageMethods.length; i++) {
    var workboxItems = workboxPackageMethods[i].toString().trim().split(',');
    for (var j = 0; j < workboxItems.length; j++) {
      var workboxItem = workboxItems[j];
      var firstColonIndex = workboxItem.indexOf(':');
      if (firstColonIndex > -1) {
        var workboxPackage = workboxItem.trim().substring(firstColonIndex + 1, workboxItem.indexOf(':', firstColonIndex + 1));
        workboxPackages.push(workboxPackage);
      }
    }
  }
  return Array.from(new Set(workboxPackages));
} catch (e) { return [] }
''';

SELECT
  client,
  workbox_package,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM `httparchive.crawl.pages`,
  UNNEST(getWorkboxPackages(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.workboxInfo')))) AS workbox_package
JOIN (
  SELECT client, COUNT(0) AS total
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-06-01' AND is_root_page AND
    JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
  GROUP BY client
) totals USING (client)
WHERE date = DATE '2025-06-01' AND is_root_page AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.workboxInfo')) NOT IN ('[]', '{}', 'null') AND
  JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
GROUP BY client, workbox_package, total
ORDER BY pct DESC, client;
