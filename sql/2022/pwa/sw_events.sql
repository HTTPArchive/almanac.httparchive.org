#standardSQL
# SW events

CREATE TEMPORARY FUNCTION getSWEvents(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var payloadJSON = JSON.parse(payload);
  var swEventListenersInfo = (Object.values(payloadJSON.swEventListenersInfo)).flat();
  var swPropertiesInfo = (Object.values(payloadJSON.swPropertiesInfo)).flat();
  return [...new Set([...swEventListenersInfo ,...swPropertiesInfo])];
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  event,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2022_06_01_*`,
  UNNEST(getSWEvents(JSON_EXTRACT(payload, '$._pwa'))) AS event
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2022_06_01_*`
  WHERE
    JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true'
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true'
GROUP BY
  client,
  total,
  event
ORDER BY
  freq / total DESC,
  client
