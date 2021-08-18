#standardSQL
# SW install events
# TODO add filter to eliminate false positives (e.g Youtube)
CREATE TEMPORARY FUNCTION getInstallEvents(windowEventListeners ARRAY<STRING>, windowPropertiesInfo ARRAY<STRING>)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var installEvents = windowEventListeners.concat(windowPropertiesInfo);
  return Array.from(new Set(installEvents));
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
  install_event,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
    `httparchive.sample_data.pages_*`,
    --`httparchive.pages.2021_07_01_*`,
    UNNEST(getInstallEvents(parseField(JSON_EXTRACT(payload, '$._pwa.windowEventListenersInfo')), parseField(JSON_EXTRACT(payload, '$._pwa.windowPropertiesInfo')))) AS install_event
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
    `httparchive.sample_data.pages_*`
      -- `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa') != "[]"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  (JSON_EXTRACT(payload, '$._pwa.windowEventListenersInfo') != "[]" OR JSON_EXTRACT(payload, '$._pwa.windowPropertiesInfo') != "[]")
GROUP BY
  client,
  total,
  install_event
ORDER BY
  freq / total DESC,
  client