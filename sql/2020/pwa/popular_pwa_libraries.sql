#standardSQL
# Popular PWA libraries based on unique ImportScript values
# Use popular_pwa_libraries_helper.sql to find libraries to count
SELECT
  date,
  client,
  COUNT(0) AS total,
  COUNTIF(LOWER(body) LIKE '%importscript%') AS uses_importscript,
  COUNTIF(LOWER(body) LIKE '%workbox%') AS workbox,
  COUNTIF(LOWER(body) LIKE '%sw-toolbox%') AS sw_toolbox,
  COUNTIF(LOWER(body) LIKE '%firebase%') AS firebase,
  COUNTIF(LOWER(body) LIKE '%onesignalsdk%') AS OneSignalSDK,
  COUNTIF(LOWER(body) LIKE '%najva%') AS najva,
  COUNTIF(LOWER(body) LIKE '%upush%') AS upush,
  COUNTIF(LOWER(body) LIKE '%cache-polyfill%') AS cache_polyfill,
  COUNTIF(LOWER(body) LIKE '%analytics-helper%') AS analytics_helper,
  COUNTIF(LOWER(body) LIKE '%importscript%' AND
    LOWER(body) NOT LIKE '%workbox%' AND
    LOWER(body) NOT LIKE '%sw-toolbox%' AND
    LOWER(body) NOT LIKE '%firebase%' AND
    LOWER(body) NOT LIKE '%onesignalsdk%' AND
    LOWER(body) NOT LIKE '%najva%' AND
    LOWER(body) NOT LIKE '%upush%' AND
    LOWER(body) NOT LIKE '%cache-polyfill%' AND
    LOWER(body) NOT LIKE '%analytics-helper%') AS importscript_nolib,
  COUNTIF(LOWER(body) NOT LIKE '%importscript%' AND
    LOWER(body) NOT LIKE '%workbox%' AND
    LOWER(body) NOT LIKE '%sw-toolbox%' AND
    LOWER(body) NOT LIKE '%firebase%' AND
    LOWER(body) NOT LIKE '%onesignalsdk%' AND
    LOWER(body) NOT LIKE '%najva%' AND
    LOWER(body) NOT LIKE '%upush%' AND
    LOWER(body) NOT LIKE '%cache-polyfill.js%' AND
    LOWER(body) NOT LIKE '%analytics-helper.js%') AS none_of_the_above
FROM
  (
    SELECT
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
