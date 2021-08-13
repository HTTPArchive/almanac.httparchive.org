#standardSQL
# SW events

CREATE TEMPORARY FUNCTION getSWEvents(swEventListenersInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var swEvents = Object.values(JSON.parse(swEventListenersInfo));
  if (typeof swEvents != 'string') {
    swEvents = swEvents.toString();
  }
  swEvents = swEvents.trim().split(',');
  return Array.from(new Set(swEvents));
} catch (e) {
  return [e];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  event,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getSWEvents(JSON_EXTRACT(payload, '$._pwa.swEventListenersInfo'))) AS event
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa') != "[]" AND
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
   JSON_EXTRACT(payload, '$._pwa') != "[]" AND
   JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true" AND
   JSON_EXTRACT(payload, '$._pwa.swEventListenersInfo') != "[]"
GROUP BY
  client,
  total,
  event
ORDER BY
  freq / total DESC
