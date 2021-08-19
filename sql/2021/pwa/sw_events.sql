#standardSQL
# SW events

CREATE TEMPORARY FUNCTION getSWEvents(swEventListenersInfo STRING, swPropertiesInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var swEventsListeners = new Array(0);
  var swEventsOn = new Array(0);

  /* get the addEventListener(XXXX, ...) events */
  if (swEventListenersInfo != '[]') {
    swEventsListeners = Object.values(JSON.parse(swEventListenersInfo));
    if (typeof swEventsListeners != 'string') {
      swEventsListeners = swEventsListeners.toString();
    }
    swEventsListeners = swEventsListeners.trim().split(',');
    swEventsListeners = Array.from(new Set(swEventsListeners));
  }

  /* get the onXXXX events */
  if (swPropertiesInfo != '[]') {
    var swEventsOn = Object.values(JSON.parse(swPropertiesInfo));
    if (typeof swEventsOn != 'string') {
      swEventsOn = swEventsOn.toString();
    }
    swEventsOn = swEventsOn.trim().split(',');
    swEventsOn = Array.from(new Set(swEventsOn));
  }

  /* Combine the two */
  var swEvents = swEventsListeners.concat(swEventsOn);
  /* Filter out any duplicates - note BigQuery doesn't have Array.unique() :-( */
  swEvents = swEvents.filter((item, pos) => swEvents.indexOf(item) === pos)
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
  UNNEST(getSWEvents(JSON_EXTRACT(payload, '$._pwa.swEventListenersInfo'), JSON_EXTRACT(payload, '$._pwa.swPropertiesInfo'))) AS event
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
  (
    JSON_EXTRACT(payload, '$._pwa.swEventListenersInfo') != "[]" OR
    JSON_EXTRACT(payload, '$._pwa.swPropertiesInfo') != "[]"
  )
GROUP BY
  client,
  total,
  event
ORDER BY
  freq / total DESC,
  client
