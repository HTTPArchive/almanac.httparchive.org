# standard SQL
# 11_01.sql
# 
# Calculate current SW controlled page install
#
# BigQuery usage notes: 
# == `httparchive.almanac.pages_*` 82.6 MB
# == archive.summary_requests = 117.5 GB 

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
