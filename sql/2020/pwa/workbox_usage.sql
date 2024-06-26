#standardSQL
# Workbox usage - based on 2019/14_05.sql
SELECT
  client,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.almanac.service_workers`
JOIN (SELECT client, COUNT(DISTINCT page) AS total FROM `httparchive.almanac.service_workers` WHERE date = '2020-08-01' GROUP BY client)
USING (client),
  UNNEST(REGEXP_EXTRACT_ALL(body, r'(?i)new workbox|workbox\.precaching\.|workbox\.strategies\.')) AS occurrence
WHERE
  date = '2020-08-01'
GROUP BY
  client,
  total
ORDER BY
  freq / total DESC
