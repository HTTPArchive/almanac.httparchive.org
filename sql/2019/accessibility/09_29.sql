#standardSQL
# 09_29: Sites with sufficient text color contrast with its background
SELECT
  COUNT(0) AS total_sites,
  COUNTIF(color_contrast_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) AS total_sufficient,
  ROUND(COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) * 100 / COUNTIF(color_contrast_score IS NOT NULL), 2) AS perc_in_applicable,
  ROUND(COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) * 100 / COUNT(0), 2) AS perc_in_all_sites
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') AS color_contrast_score
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
