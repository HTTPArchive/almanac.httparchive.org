# standard SQL
# 11_01.sql
# 
# Calculate current SW controlled page install
#
# BigQuery usage notes: 
# == `httparchive.almanac.pages_*` 82.6 MB
# == archive.summary_requests = 117.5 GB 

SELECT
  _TABLE_SUFFIX AS client,
  count(0) as tot,
  ROUND(SUM(IF(JSON_EXTRACT(payload, '$._blinkFeatureFirstUsed.Features.ServiceWorkerControlledPage') IS NOT NULL, 1, 0)) * 100 / COUNT(0), 2) AS percent
FROM
  `httparchive.almanac.pages_*`
GROUP BY
  client
ORDER BY
  client
