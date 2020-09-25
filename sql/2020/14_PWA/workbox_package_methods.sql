#standardSQL
# Workbox package and methods
SELECT
  client,
  workbox_package,
  workbox_method,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.service_workers`
JOIN
  (SELECT client, COUNT(DISTINCT page) AS total FROM `httparchive.almanac.service_workers` WHERE date = '2020-08-01' GROUP BY client)
USING (client),
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(body, r'workbox\.([a-zA-Z]+\.?[a-zA-Z]*)'))) AS workbox,
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(workbox, r'([a-zA-Z]+)\.?[a-zA-Z]*'))) AS workbox_package,
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(workbox, r'([a-zA-Z]+\.?[a-zA-Z]*)'))) AS workbox_method
WHERE
  date = '2020-08-01' AND
  # Exclude JS files themselves as only interested in functions
  workbox_method not like ('%js') AND
  workbox_method not like ('%js.map')
GROUP BY
  client,
  total,
  workbox_package,
  workbox_method
ORDER BY
  freq / total DESC
