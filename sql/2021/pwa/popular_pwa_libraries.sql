#standardSQL
# Popular PWA script
CREATE TEMPORARY FUNCTION getSWLibraries(importScriptsInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  /* 'importScriptsInfo' returns an array of script that might import other script
     The final array of script comes from the combination of both */
  var ObjKeys = Object.keys(JSON.parse(importScriptsInfo));
  var ObjValues = Object.values(JSON.parse(importScriptsInfo));
  var script = ObjKeys.concat(ObjValues);
  /* Replacing spaces and commas */
  for (var i = 0; i < script.length; i++) {
      script[i] = script[i].toString().trim().replace(/'/g, "");
  }

  /* Creating a Set to eliminate duplicates and transforming back to an array to respect the function signature */
  return Array.from(new Set(script));
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
FROM
  (
    SELECT
      _TABLE_SUFFIX AS client,
      url,
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
      COUNTIF(LOWER(script) NOT LIKE '%workbox%' AND
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
        LOWER(script) NOT LIKE '%quora%') AS none_of_the_above
    FROM
      `httparchive.pages.2021_07_01_*`,
      UNNEST(getSWLibraries(JSON_EXTRACT(payload, '$._pwa.importScriptsInfo'))) AS script
    WHERE
      JSON_EXTRACT(payload, '$._pwa.importScriptsInfo') != "[]" AND
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX,
      url
  )
JOIN
  (
    SELECT
      _TABLE_SUFFIX AS client,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      client
  )
USING (client)
GROUP BY
  client,
  total
ORDER BY
  client
