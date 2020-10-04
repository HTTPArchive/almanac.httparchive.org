#standardSQL
# Sites registering a service worker
SELECT
  COUNT(0) AS total,
  COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.service-worker.score') as NUMERIC) = 1) AS score_sum,
  ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.service-worker.score') as NUMERIC) = 1) * 100 / COUNT(0), 2) as score_percentage
FROM
  `httparchive.lighthouse.2020_08_01_mobile`
