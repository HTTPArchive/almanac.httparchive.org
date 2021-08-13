#standardSQL
#Workbox package and methods
CREATE TEMPORARY FUNCTION getWorkboxPackages(workboxInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {

  var workboxPackageMethods = Object.values(JSON.parse(workboxInfo));
  if (typeof workboxPackageMethods == 'string') {
    workboxPackageMethods = [workboxPackageMethods];
  }
  var workboxPackages = [];
  /* Replacing spaces and commas */
  for (var i = 0; i < workboxPackageMethods.length; i++) {
      var workboxItems = workboxPackageMethods[i].toString().trim().split(',');
      for(var j = 0; j < workboxItems.length; j++) {
        var workboxItem = workboxItems[j];
        var firstColonIndex = workboxItem.indexOf(':');
        if(firstColonIndex > -1) {
          var workboxPackage = workboxItem.trim().substring(0, workboxItem.indexOf(':', firstColonIndex + 1));
          workboxPackages.push(workboxPackage);
        }
      }
  }
  return Array.from(new Set(workboxPackages));
} catch (e) {
  return [e];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  workbox_package,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getWorkboxPackages(JSON_EXTRACT(payload, '$._pwa.workboxInfo'))) AS workbox_package
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa') != "[]" AND
      JSON_EXTRACT(payload, '$._pwa. serviceWorkerHeuristics') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.workboxInfo') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa. serviceWorkerHeuristics') = "true"
GROUP BY
  client,
  workbox_package,
  total
ORDER BY
  pct DESC,
  client
