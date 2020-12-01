#standardSQL
# % mobile sites with correctly sized tap targets (note: the score is not binary)
SELECT
  COUNTIF(color_contrast_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) AS total_sufficient,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) / COUNTIF(color_contrast_score IS NOT NULL) AS perc_in_applicable
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.tap-targets.score') AS color_contrast_score
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`
)
