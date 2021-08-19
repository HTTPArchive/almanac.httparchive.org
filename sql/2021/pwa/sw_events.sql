#standardSQL
# SW events

CREATE TEMPORARY FUNCTION getSWEvents(swEventListenersInfo ARRAY<STRING>, swPropertiesInfo ARRAY<STRING>)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  return [...new Set([...swEventListenersInfo ,...swPropertiesInfo])];
} catch (e) {
  return [e];
}
''';

CREATE TEMPORARY FUNCTION parseField(field STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
 try {
     if(field == '[]' || field == '') {
         return [];
     }
     var parsedField = Object.values(JSON.parse(field));
     if (typeof parsedField != 'string') {
         parsedField = parsedField.toString();
     }
     parsedField = parsedField.trim().split(',');
     return parsedField;
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
  UNNEST(getSWEvents(parseField(JSON_EXTRACT(payload, '$._pwa.swEventListenersInfo')), parseField(JSON_EXTRACT(payload, '$._pwa.swPropertiesInfo')))) AS event
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
