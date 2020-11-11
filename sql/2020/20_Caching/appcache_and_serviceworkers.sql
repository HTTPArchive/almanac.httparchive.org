#standardSQL
# Use of AppCache and ServiceWorkers
SELECT
  IF(STARTS_WITH(url, 'https'), 'https', 'http') AS http_type,
  JSON_EXTRACT_SCALAR(report, "$.audits.appcache-manifest.score") AS using_appcache,
  JSON_EXTRACT_SCALAR(report, "$.audits.service-worker.score") AS using_serviceworkers,
  count(*) AS occurences     
FROM 
  `httparchive.lighthouse.2020_08_01_mobile` 
GROUP BY 
  http_type, 
  using_appcache, 
  using_serviceworkers
ORDER BY
  http_type, 
  using_appcache, 
  using_serviceworkers
