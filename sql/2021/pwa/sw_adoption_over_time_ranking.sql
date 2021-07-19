#standardSQL
# SW adoption over time - based on 2019/11_01b.sql
SELECT
  yyyymmdd AS date,
  client,
  ranking,
  COUNT(0) AS freq,
  total AS total,
  COUNT(0)/total AS pct
FROM
  `httparchive.blink_features.features` f
JOIN
  (
  SELECT REPLACE(SUBSTR(_TABLE_SUFFIX,0,10),'_','') AS yyyymmdd, SUBSTR(_TABLE_SUFFIX,12) AS client, rank as ranking, COUNT(0) as total
  FROM `httparchive.summary_pages.*`
  WHERE _TABLE_SUFFIX > '2021_05_01'
  GROUP BY yyyymmdd, client, ranking
  )
USING
  (yyyymmdd, client)
JOIN
  (SELECT REPLACE(SUBSTR(_TABLE_SUFFIX,0,10),'_','') AS yyyymmdd, SUBSTR(_TABLE_SUFFIX,12) AS client, rank as ranking, url
  FROM `httparchive.summary_pages.*`
  WHERE _TABLE_SUFFIX > '2021_05_01')
USING
  (yyyymmdd, client, url, ranking)
WHERE
  feature = 'ServiceWorkerControlledPage'
   AND yyyymmdd >= '20210501'
GROUP BY
  yyyymmdd,
  client,
  ranking,
  total
ORDER BY
  date DESC,
  ranking,
  client
