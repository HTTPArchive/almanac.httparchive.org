#standardSQL
# Workbox package and methods
#
# TODO - CONVERT TO USE CUSTOM METRICS
#
SELECT
  client,
  workbox_package,
  workbox_method,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.almanac.service_workers`
JOIN
  (SELECT client, COUNT(DISTINCT page) AS total FROM `httparchive.almanac.service_workers` WHERE date = '2021-07-01' GROUP BY client)
USING (client),
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(body, r'workbox\.([a-zA-Z]+\.?[a-zA-Z]*)'))) AS workbox,
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(workbox, r'([a-zA-Z]+)\.?[a-zA-Z]*'))) AS workbox_package,
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(workbox, r'([a-zA-Z]+\.?[a-zA-Z]*)'))) AS workbox_method
WHERE
  date = '2021-07-01' AND
  # Exclude JS files themselves as only interested in functions
  workbox_method NOT LIKE ('%js') AND
  workbox_method NOT LIKE ('%js.map')
GROUP BY
  client,
  total,
  workbox_package,
  workbox_method
ORDER BY
  freq / total DESC,
  workbox_package,
  workbox_method,
  client
