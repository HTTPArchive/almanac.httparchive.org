#standardSQL
# SW adoption over time when filtered to top 1k sites (only available from May 2021)
# This is to show if the most popular websites use service workers more often than regular internet. and by how nmuch.
SELECT
  yyyymmdd AS date,
  client,
  COUNT(0) AS freq,
  total AS total,
  COUNT(0)/total AS pct
FROM
  `httparchive.blink_features.features`
JOIN
  (
  SELECT REPLACE(SUBSTR(_TABLE_SUFFIX,0,10),'_','') AS yyyymmdd, SUBSTR(_TABLE_SUFFIX,12) AS client, COUNT(0) as total FROM `httparchive.summary_pages.*` WHERE rank = 1000 AND _TABLE_SUFFIX > '2021_05_01'
  GROUP BY yyyymmdd, client
  )
USING
  (yyyymmdd, client)
JOIN
  (SELECT REPLACE(SUBSTR(_TABLE_SUFFIX,0,10),'_','') AS yyyymmdd, SUBSTR(_TABLE_SUFFIX,12) AS client, url FROM `httparchive.summary_pages.*` WHERE rank = 1000 AND _TABLE_SUFFIX > '2021_05_01')
USING
  (yyyymmdd, client, url)
WHERE
  feature = 'ServiceWorkerControlledPage'
   AND yyyymmdd >= '20210501'
GROUP BY
  yyyymmdd,
  client,
  total
ORDER BY
  date DESC,
  client
