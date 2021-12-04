#standardSQL
# Max TBT

SELECT
  MAX(CAST(JSON_EXTRACT_SCALAR(report, "$.audits.total-blocking-time.numericValue") AS FLOAT64)) AS maxTbt
FROM
  `httparchive.lighthouse.2021_07_01_mobile`
