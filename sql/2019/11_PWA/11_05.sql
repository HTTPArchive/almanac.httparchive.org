#standardSQL
# 11_05: Workbox usage
SELECT
  client,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.service_workers`
JOIN
  (SELECT client, COUNT(DISTINCT page) AS total FROM `httparchive.almanac.service_workers` GROUP BY client)
USING (client),
  UNNEST(REGEXP_EXTRACT_ALL(body, r'new Workbox|new workbox|workbox\.precaching\.|workbox\.strategies\.')) AS occurrence
GROUP BY
  client,
  total
ORDER BY
  freq / total DESC
