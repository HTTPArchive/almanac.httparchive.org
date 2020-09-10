# standard SQL
# % SW controlled pages - based on 2019/11_01.sql: 
SELECT
  client,
  num_urls AS freq,
  total_urls AS total,
  ROUND(pct_urls * 100, 2) AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20200801' AND
  feature = 'ServiceWorkerControlledPage'