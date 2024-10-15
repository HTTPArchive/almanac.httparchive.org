#standardSQL
# SW methods
CREATE TEMPORARY FUNCTION getSWMethods(swMethodsInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var swMethods = JSON.parse(swMethodsInfo);
  return Array.from(new Set(Object.values(swMethods).flat()));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  sw_method,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getSWMethods(JSON_EXTRACT(payload, '$._pwa.swMethodsInfo'))) AS sw_method
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
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true' AND
  JSON_EXTRACT(payload, '$._pwa.swMethodsInfo') != '[]'
GROUP BY
  client,
  total,
  sw_method
ORDER BY
  freq / total DESC,
  client
