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
  client,
  install_event,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.crawl.pages`,
  UNNEST(getInstallEvents(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa')))) AS install_event
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = DATE '2025-06-01' AND is_root_page AND
    -- This condition filters out tests that might have broken when running the 'pwa' metric
    -- as even pages without any pwa capabilities will have a _pwa object with empty fields
    TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa')) != '[]'
  GROUP BY
    client
)
USING (client)
WHERE date = DATE '2025-06-01' AND is_root_page AND (
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.windowEventListenersInfo')) != '[]' OR
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.windowPropertiesInfo')) != '[]'
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
