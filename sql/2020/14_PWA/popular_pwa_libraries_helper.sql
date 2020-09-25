#standardSQL
# Use this sql to find popular library imports for popular_pwa_libraries.sql
SELECT
  client,
  ImportScript,
  count(0) AS COUNT
FROM
  `httparchive.almanac.service_workers`,
  UNNEST(ARRAY_CONCAT(REGEXP_EXTRACT_ALL(body, r'(?i)importscripts\([\'"]([^(]*)[\'"]\)'))) AS ImportScript
WHERE
  date = '2020-08-01' AND
  lower(body) LIKE '%importscripts%' AND
  lower(ImportScript) NOT LIKE '%workbox%' AND
  lower(ImportScript) NOT LIKE '%sw-toolbox%' AND
  lower(ImportScript) NOT LIKE '%firebase%' AND
  lower(ImportScript) NOT LIKE '%onesignalsdk%' AND
  lower(ImportScript) NOT LIKE '%najva%' AND
  lower(ImportScript) NOT LIKE '%upush%' AND
  lower(ImportScript) NOT LIKE '%ache-polyfill%' AND
  lower(ImportScript) NOT LIKE '%analytics-helper%'  
GROUP BY
  client,
  ImportScript
ORDER BY
  count(0) desc
  