#standardSQL
# Use of AppCache and ServiceWorkers
SELECT
  IF(STARTS_WITH(url, 'https'), 'https', 'http') AS http_type,
  JSON_EXTRACT_SCALAR(report, "$.audits.appcache-manifest.score") AS using_appcache,
  JSON_EXTRACT_SCALAR(report, "$.audits.service-worker.score") AS using_serviceworkers,
  COUNT(0) AS occurrences,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM
  `httparchive.lighthouse.2020_08_01_mobile`
GROUP BY
  http_type,
  using_appcache,
  using_serviceworkers
ORDER BY
  pct DESC
