#standardSQL
#Workbox versions
CREATE TEMPORARY FUNCTION getWorkboxVersions(workboxInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var workboxPackageMethods = Object.values(JSON.parse(workboxInfo));
  if (typeof workboxPackageMethods == 'string') {
    workboxPackageMethods = [workboxPackageMethods];
  }
  var workboxVersions = [];
  /* Replacing spaces and commas */
  for (var i = 0; i < workboxPackageMethods.length; i++) {
      var workboxItems = workboxPackageMethods[i].toString().trim().split(',');
      for(var j = 0; j < workboxItems.length; j++) {
        var workboxItem = workboxItems[j];
        var firstColonIndex = workboxItem.indexOf(':');
        if(firstColonIndex > -1) {
          var workboxVersion = workboxItem.trim().substring(workboxItem.indexOf(':', firstColonIndex + 1) + 1);
          workboxVersions.push(workboxVersion);
        }
      }
  }
  return Array.from(new Set(workboxVersions));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  workbox_version,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getWorkboxVersions(JSON_EXTRACT(payload, '$._pwa.workboxInfo'))) AS workbox_version
JOIN
  (
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
  _TABLE_SUFFIX,
  workbox_version,
  total
ORDER BY
  pct DESC,
  client
