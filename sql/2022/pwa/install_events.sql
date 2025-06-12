#standardSQL
# SW install events

CREATE TEMPORARY FUNCTION getInstallEvents(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var payloadJSON = JSON.parse(payload);

  /* YouTube iFrames account for a lot of these, so we exclude them */
  /* Cannot use filter as it is a complex object and not a straight array */
  function filterYouTube(info) {

    var objectKeys = Object.keys(info);
    objectKeys = objectKeys.trim().split(',');
    for(var i = 0; i < objectKeys.length; i++) {
        if(objectKeys[i].toLowerCase().includes('youtube')) {
            delete info[objectKeys[i]];
        }
    }
    return info;
  }

  var windowEventListenersInfo = Object.values(filterYouTube(payloadJSON.windowEventListenersInfo)).flat();
  var windowPropertiesInfo = Object.values(filterYouTube(payloadJSON.windowPropertiesInfo)).flat()

  return [...new Set([...windowEventListenersInfo ,...windowPropertiesInfo])];
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  install_event,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2022_06_01_*`,
  UNNEST(getInstallEvents(JSON_EXTRACT(payload, '$._pwa'))) AS install_event
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2022_06_01_*`
  WHERE
    -- This condition filters out tests that might have broken when running the 'pwa' metric
    -- as even pages without any pwa capabilities will have a _pwa object with empty fields
    JSON_EXTRACT(payload, '$._pwa') != '[]'
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE (
  JSON_EXTRACT(payload, '$._pwa.windowEventListenersInfo') != '[]' OR
  JSON_EXTRACT(payload, '$._pwa.windowPropertiesInfo') != '[]'
) AND
install_event != '' AND
install_event != '[]'
GROUP BY
  client,
  total,
  install_event
ORDER BY
  freq / total DESC,
  client
