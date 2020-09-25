#standardSQL
# Counting Manifests and Service Workers
SELECT
  date,
  client,
  count(DISTINCT m.page) AS Manifests,
  count(DISTINCT sw.page) AS ServiceWorkers,
  count(DISTINCT IFNULL(m.page, sw.page)) AS Either,
  count(DISTINCT (m.page || sw.page)) AS Both
FROM
  `httparchive.almanac.manifests` m
FULL OUTER JOIN
  `httparchive.almanac.service_workers` sw
USING
  (date, client, page)
GROUP BY
  date,
  client
ORDER BY
  date,
  client
