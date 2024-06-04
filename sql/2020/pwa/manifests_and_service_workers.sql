#standardSQL
# Counting Manifests and Service Workers
# Currently showing both years but should change to just current year in future
SELECT
  date,
  client,
  manifests / total AS manifests_pct,
  serviceworkers / total AS serviceworkers_pct,
  either / total AS either_pct,
  both / total AS both_pct,
  total
FROM (
  SELECT
    date,
    client,
    COUNT(DISTINCT m.page) AS manifests,
    COUNT(DISTINCT sw.page) AS serviceworkers,
    COUNT(DISTINCT IFNULL(m.page, sw.page)) AS either,
    COUNT(DISTINCT m.page || sw.page) AS both
  FROM
    `httparchive.almanac.manifests` m
  FULL OUTER JOIN
    `httparchive.almanac.service_workers` sw
  USING (date, client, page)
  GROUP BY
    date,
    client
)
JOIN (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.almanac.summary_requests`
  GROUP BY
    date,
    client
)
USING (date, client)
ORDER BY
  date,
  client
