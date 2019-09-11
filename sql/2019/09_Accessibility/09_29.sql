#standardSQL
# 09_29: Sites with sufficient text color contrast with its background
SELECT
  COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC) = 1) AS total_sufficient,
  COUNT(0) AS total_sites,
  ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC) = 1) * 100 / COUNT(0), 2) AS sufficient_percent
FROM
  `httparchive.lighthouse.2019_07_01_mobile`
