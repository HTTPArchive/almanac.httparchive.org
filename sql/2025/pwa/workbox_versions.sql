#standardSQL
# Workbox versions (2025)

CREATE TEMPORARY FUNCTION getWorkboxVersions(workboxInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var workboxPackageMethods = Object.values(JSON.parse(workboxInfo || '{}'));
  if (typeof workboxPackageMethods == 'string') {
    workboxPackageMethods = [workboxPackageMethods];
  }
  var workboxVersions = [];
  for (var i = 0; i < workboxPackageMethods.length; i++) {
    var workboxItems = workboxPackageMethods[i].toString().trim().split(',');
    for (var j = 0; j < workboxItems.length; j++) {
      var workboxItem = workboxItems[j];
      var firstColonIndex = workboxItem.indexOf(':');
      if (firstColonIndex > -1) {
        var workboxVersion = workboxItem.trim().substring(workboxItem.indexOf(':', firstColonIndex + 1) + 1);
        workboxVersions.push(workboxVersion);
      }
    }
  }
  return Array.from(new Set(workboxVersions));
} catch (e) { return [] }
''';

SELECT
  client,
  workbox_version,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.crawl.pages`,
  UNNEST(getWorkboxVersions(TO_JSON_STRING(custom_metrics.other.pwa.workboxInfo))) AS workbox_version
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true'
  GROUP BY
    client
) totals USING (client)
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  TO_JSON_STRING(custom_metrics.other.pwa.workboxInfo) NOT IN ('[]', '{}', 'null') AND
  JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true'
GROUP BY
  client,
  workbox_version,
  total
ORDER BY
  pct DESC,
  client;
