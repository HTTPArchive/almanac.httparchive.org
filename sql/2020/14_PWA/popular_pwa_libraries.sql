#standardSQL
# Popular PWA libraries based on unique ImportScript values
# Use popular_pwa_libraries_helper.sql to find libraries to count
SELECT
  date,
  client,
  count(0) AS total,
  COUNTIF(lower(body) LIKE '%importscript%') AS uses_importscript,
  COUNTIF(lower(body) LIKE '%workbox%') AS workbox,
  COUNTIF(lower(body) LIKE '%sw-toolbox%') AS sw_toolbox,
  COUNTIF(lower(body) LIKE '%firebase%') AS firebase,
  COUNTIF(lower(body) LIKE '%onesignalsdk%') AS OneSignalSDK,
  COUNTIF(lower(body) LIKE '%najva%') AS najva,
  COUNTIF(lower(body) LIKE '%upush%') AS upush,
  COUNTIF(lower(body) LIKE '%cache-polyfill%') AS cache_polyfill,
  COUNTIF(lower(body) LIKE '%analytics-helper%') AS analytics_helper,
  COUNTIF(lower(body) LIKE '%importscript%' AND
    lower(body) NOT LIKE '%workbox%' AND
    lower(body) NOT LIKE '%sw-toolbox%' AND
    lower(body) NOT LIKE '%firebase%' AND
    lower(body) NOT LIKE '%onesignalsdk%' AND
    lower(body) NOT LIKE '%najva%' AND
    lower(body) NOT LIKE '%upush%' AND
    lower(body) NOT LIKE '%cache-polyfill%' AND
    lower(body) NOT LIKE '%analytics-helper%') AS importscript_nolib,
  COUNTIF(lower(body) NOT LIKE '%importscript%' AND
    lower(body) NOT LIKE '%workbox%' AND
    lower(body) NOT LIKE '%sw-toolbox%' AND
    lower(body) NOT LIKE '%firebase%' AND
    lower(body) NOT LIKE '%onesignalsdk%' AND
    lower(body) NOT LIKE '%najva%' AND
    lower(body) NOT LIKE '%upush%' AND
    lower(body) NOT LIKE '%cache-polyfill.js%' AND
    lower(body) NOT LIKE '%analytics-helper.js%') AS none_of_the_above,
  COUNTIF(lower(body) LIKE '%workbox%')/count(0) AS workbox_pct,
  COUNTIF(lower(body) LIKE '%sw-toolbox%')/count(0) AS sw_toolbox_pct,
  COUNTIF(lower(body) LIKE '%firebase%')/count(0) AS firebase_pct,
  COUNTIF(lower(body) LIKE '%onesignalsdk%')/count(0) AS OneSignalSDK_pct,
  COUNTIF(lower(body) LIKE '%najva%')/count(0) AS najva_pct,
  COUNTIF(lower(body) LIKE '%upush%')/count(0) AS upush_pct,
  COUNTIF(lower(body) LIKE '%cache-polyfill%')/count(0) AS cache_polyfill_pct,
  COUNTIF(lower(body) LIKE '%analytics-helper%')/count(0) AS analytics_helper_pct,
  COUNTIF(lower(body) LIKE '%importscript%' AND
    lower(body) NOT LIKE '%workbox%' AND
    lower(body) NOT LIKE '%sw-toolbox%' AND
    lower(body) NOT LIKE '%firebase%' AND
    lower(body) NOT LIKE '%onesignalsdk%' AND
    lower(body) NOT LIKE '%najva%' AND
    lower(body) NOT LIKE '%upush%' AND
    lower(body) NOT LIKE '%cache-polyfill%' AND
    lower(body) NOT LIKE '%analytics-helper%')/count(0) AS importscript_nolib_pct,
  COUNTIF(lower(body) NOT LIKE '%importscript%' AND
    lower(body) NOT LIKE '%workbox%' AND
    lower(body) NOT LIKE '%sw-toolbox%' AND
    lower(body) NOT LIKE '%firebase%' AND
    lower(body) NOT LIKE '%onesignalsdk%' AND
    lower(body) NOT LIKE '%najva%' AND
    lower(body) NOT LIKE '%upush%' AND
    lower(body) NOT LIKE '%cache-polyfill%' AND
    lower(body) NOT LIKE '%analytics-helper%')/count(0) AS none_of_the_above_pct
FROM
  (
    SELECT DISTINCT
      date,
      client,
      page,
      body
    FROM
      `httparchive.almanac.service_workers`
    GROUP BY
      date,
      client,
      page,
      body
  )
GROUP BY
  date,
  client
ORDER BY
  date,
  client
