#standardSQL
# SW objects
CREATE TEMPORARY FUNCTION getSWObjects(swObjectsInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var swObjects = Object.values(JSON.parse(swObjectsInfo));
  if (typeof swObjects != 'string') {
    swObjects = swObjects.toString();
  }
  swObjects = swObjects.trim().split(',').map(x => x.split('.')[0]);
  return Array.from(new Set(swObjects));
} catch (e) {
  return [];
}
''';
SELECT
  _TABLE_SUFFIX AS client,
  sw_object,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getSWObjects(JSON_EXTRACT(payload, '$._pwa.swObjectsInfo'))) AS sw_object
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true" AND
  JSON_EXTRACT(payload, '$._pwa.swObjectsInfo') != "[]"
GROUP BY
  client,
  total,
  sw_object
ORDER BY
  freq / total DESC,
  client
