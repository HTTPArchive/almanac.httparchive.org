#standardSQL
# 08_19: Sites that have associated labels for their form elements
SELECT
  COUNT(0) AS total_sites,
  COUNTIF(label_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(label_score as NUMERIC) = 1) AS total_sufficient,
  ROUND(COUNTIF(CAST(label_score as NUMERIC) = 1) * 100 / COUNTIF(label_score IS NOT NULL), 2) AS perc_in_applicable
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.label.score') as label_score
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`
)
