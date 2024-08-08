#standardSQL
#Workbox methods
CREATE TEMPORARY FUNCTION getWorkboxMethods(workboxInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var workboxPackageMethods = Object.values(JSON.parse(workboxInfo));
  if (typeof workboxPackageMethods == 'string') {
    workboxPackageMethods = [workboxPackageMethods];
  }
  var workboxMethods = [];
  /* Replacing spaces and commas */
  for (var i = 0; i < workboxPackageMethods.length; i++) {
      var workboxItems = workboxPackageMethods[i].toString().trim().split(',');
      for(var j = 0; j < workboxItems.length; j++) {
        if(workboxItems[j].indexOf(':') == -1) {
          if (workboxItems[j].trim().startsWith('workbox.')) {
            workboxMethods.push(workboxItems[j].trim().substring(8));
          }
        }
      }
  }
  return Array.from(new Set(workboxMethods));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  workbox_method,
  REGEXP_EXTRACT(workbox_method, r'^([^.]+)') AS module_only,
  REGEXP_EXTRACT(workbox_method, r'^[^.]+\.([^.]+)') AS method_only,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getWorkboxMethods(JSON_EXTRACT(payload, '$._pwa.workboxInfo'))) AS workbox_method
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2021_07_01_*`
  WHERE
    JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true'
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa.workboxInfo') != '[]' AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true'
GROUP BY
  client,
  workbox_method,
  total
ORDER BY
  pct DESC,
  client
