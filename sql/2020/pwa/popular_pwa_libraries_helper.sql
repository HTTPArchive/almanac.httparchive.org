#standardSQL
# Use this sql to find popular library imports for popular_pwa_libraries.sql
# And also other importscripts used in service workers
SELECT
  client,
  importscript,
  COUNT(DISTINCT page) AS pages,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  (SELECT DISTINCT * FROM `httparchive.almanac.service_workers`)
JOIN
  (SELECT client, date, COUNT(DISTINCT page) AS total FROM `httparchive.almanac.service_workers` GROUP BY client, date)
USING (client, date),
  UNNEST(ARRAY_CONCAT(REGEXP_EXTRACT_ALL(body, r'(?i)importscripts\([\'"]([^(]*)[\'"]\)'))) AS importscript
WHERE
  date = '2020-08-01' AND
  LOWER(body) LIKE '%importscripts%' AND
  LOWER(ImportScript) NOT LIKE '%workbox%' AND
  LOWER(ImportScript) NOT LIKE '%sw-toolbox%' AND
  LOWER(ImportScript) NOT LIKE '%firebase%' AND
  LOWER(ImportScript) NOT LIKE '%onesignalsdk%' AND
  LOWER(ImportScript) NOT LIKE '%najva%' AND
  LOWER(ImportScript) NOT LIKE '%upush%' AND
  LOWER(ImportScript) NOT LIKE '%ache-polyfill%' AND
  LOWER(ImportScript) NOT LIKE '%analytics-helper%'
GROUP BY
  client,
  importscript,
  total
ORDER BY
  pct DESC,
  client
