#standardSQL
# Use this sql to find popular library imports for popular_pwa_libraries.sql
# And also other importscripts used in service workers
CREATE TEMPORARY FUNCTION getSWLibraries(importScriptsInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  /* 'importScriptsInfo' returns an array of libraries that might import other libraries
     The final array of libraries comes from the combination of both */
  var ObjKeys = Object.keys(JSON.parse(importScriptsInfo));
  var ObjValues = Object.values(JSON.parse(importScriptsInfo));
  var libraries = ObjKeys.concat(ObjValues);
  /* Replacing spaces and commas */
  for (var i = 0; i < libraries.length; i++) {
      libraries[i] = libraries[i].toString().trim().replace(/'/g, "");
  }

  /* Creating a Set to eliminate duplicates and transforming back to an array to respect the function signature */
  return Array.from(new Set(libraries));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  script,
  COUNT(DISTINCT url) AS freq
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getSWLibraries(JSON_EXTRACT(payload, '$._pwa.importScriptsInfo'))) AS script
WHERE
  JSON_EXTRACT(payload, '$._pwa.importScriptsInfo') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true" AND
  LOWER(script) NOT LIKE '%workbox%' AND
  LOWER(script) NOT LIKE '%sw-toolbox%' AND
  LOWER(script) NOT LIKE '%firebase%' AND
  LOWER(script) NOT LIKE '%onesignalsdk%' AND
  LOWER(script) NOT LIKE '%najva%' AND
  LOWER(script) NOT LIKE '%upush%' AND
  LOWER(script) NOT LIKE '%cache-polyfill.js%' AND
  LOWER(script) NOT LIKE '%analytics-helper.js%' AND
  LOWER(script) NOT LIKE '%recaptcha%' AND
  LOWER(script) NOT LIKE '%pwabuilder%'
GROUP BY
  _TABLE_SUFFIX,
  script
ORDER BY
  freq DESC
