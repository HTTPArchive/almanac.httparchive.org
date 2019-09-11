#standardSQL
# 09_29: Sites with sufficient text color contrast with its background
SELECT
  COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC) = 1) AS total_sufficient,
  COUNT(0) AS total_sites,
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') IS NOT NULL) AS total_applicable,
  ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC) = 1) * 100 / COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') IS NOT NULL), 2) AS perc_in_applicable,
  ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') as NUMERIC) = 1) * 100 / COUNT(0), 2) AS perc_in_all_sites
FROM
  `httparchive.lighthouse.2019_07_01_mobile`
