#standardSQL
# % mobile sites with sufficient text color contrast with its background
SELECT
  COUNTIF(color_contrast_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) AS total_sufficient,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) / COUNTIF(color_contrast_score IS NOT NULL) AS perc_in_applicable
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.color-contrast.score') AS color_contrast_score
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`
)
