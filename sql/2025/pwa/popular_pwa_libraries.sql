#standardSQL
# Popular PWA script (2025) — only crawl/custom_metrics updates, logic identical to 2022

CREATE TEMPORARY FUNCTION getSWLibraries(importScriptsInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const obj = JSON.parse(importScriptsInfo || '{}');
  const keys = Object.keys(obj);
  const values = Object.values(obj);
  const scripts = keys.concat(values).map(s => (s || '').toString().trim().replace(/'/g, ''));
  return Array.from(new Set(scripts));
} catch (e) {
  return [];
}
''';

SELECT
  client,
  COUNTIF(workbox > 0) / total AS workbox,
  COUNTIF(sw_toolbox > 0) / total AS sw_toolbox,
  COUNTIF(firebase > 0) / total AS firebase,
  COUNTIF(OneSignalSDK > 0) / total AS OneSignalSDK,
  COUNTIF(najva > 0) / total AS najva,
  COUNTIF(upush > 0) / total AS upush,
  COUNTIF(cache_polyfill > 0) / total AS cache_polyfill,
  COUNTIF(analytics_helper > 0) / total AS analytics_helper,
  COUNTIF(recaptcha > 0) / total AS recaptcha,
  COUNTIF(pwabuilder > 0) / total AS pwabuilder,
  COUNTIF(pushprofit > 0) / total AS pushprofit,
  COUNTIF(sendpulse > 0) / total AS sendpulse,
  COUNTIF(quora > 0) / total AS quora,
  COUNTIF(none_of_the_above > 0) / total AS none_of_the_above,
  COUNTIF(importscripts > 0) / total AS uses_importscript,
  total
FROM (
  SELECT
    client,
    page,
    COUNT(0) AS importscripts,
    COUNTIF(LOWER(script) LIKE '%workbox%') AS workbox,
    COUNTIF(LOWER(script) LIKE '%sw-toolbox%') AS sw_toolbox,
    COUNTIF(LOWER(script) LIKE '%firebase%') AS firebase,
    COUNTIF(LOWER(script) LIKE '%onesignalsdk%') AS OneSignalSDK,
    COUNTIF(LOWER(script) LIKE '%najva%') AS najva,
    COUNTIF(LOWER(script) LIKE '%upush%') AS upush,
    COUNTIF(LOWER(script) LIKE '%cache-polyfill%') AS cache_polyfill,
    COUNTIF(LOWER(script) LIKE '%analytics-helper%') AS analytics_helper,
    COUNTIF(LOWER(script) LIKE '%recaptcha%') AS recaptcha,
    COUNTIF(LOWER(script) LIKE '%pwabuilder%') AS pwabuilder,
    COUNTIF(LOWER(script) LIKE '%pushprofit%') AS pushprofit,
    COUNTIF(LOWER(script) LIKE '%sendpulse%') AS sendpulse,
    COUNTIF(LOWER(script) LIKE '%quore%') AS quora,
    COUNTIF(
      LOWER(script) NOT LIKE '%workbox%' AND
      LOWER(script) NOT LIKE '%sw-toolbox%' AND
      LOWER(script) NOT LIKE '%firebase%' AND
      LOWER(script) NOT LIKE '%onesignalsdk%' AND
      LOWER(script) NOT LIKE '%najva%' AND
      LOWER(script) NOT LIKE '%upush%' AND
      LOWER(script) NOT LIKE '%cache-polyfill.js%' AND
      LOWER(script) NOT LIKE '%analytics-helper.js%' AND
      LOWER(script) NOT LIKE '%recaptcha%' AND
      LOWER(script) NOT LIKE '%pwabuilder%' AND
      LOWER(script) NOT LIKE '%pushprofit%' AND
      LOWER(script) NOT LIKE '%sendpulse%' AND
      LOWER(script) NOT LIKE '%quora%'
    ) AS none_of_the_above
  FROM
    `httparchive.crawl.pages`,
    UNNEST(getSWLibraries(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.importScriptsInfo')))) AS script
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.importScriptsInfo')) NOT IN ('[]', '{}', 'null') AND
    JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true'
  GROUP BY
    client,
    page
)
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true'
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  total
ORDER BY
  client;
