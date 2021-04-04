# standard SQL
# 11_01: % SW controlled pages
SELECT
  client,
  num_urls AS freq,
  total_urls AS total,
  ROUND(pct_urls * 100, 2) AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20190701' AND
  feature = 'ServiceWorkerControlledPage'
