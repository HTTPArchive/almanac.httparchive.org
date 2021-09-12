#standardSQL
# pages registering a service worker
SELECT
  COUNT(0) AS total,
  COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.service-worker.score') AS NUMERIC) = 1) AS score_sum,
  COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.service-worker.score') AS NUMERIC) = 1) / COUNT(0) AS score_percentage
FROM
  `httparchive.lighthouse.2021_07_01_mobile`
