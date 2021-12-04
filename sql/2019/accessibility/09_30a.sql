#standardSQL
# 09_30a: Sites that have associated labels for their form elements
SELECT
  COUNT(0) AS total_sites,
  COUNTIF(label_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(label_score AS NUMERIC) = 1) AS total_sufficient,
  ROUND(COUNTIF(CAST(label_score AS NUMERIC) = 1) * 100 / COUNTIF(label_score IS NOT NULL), 2) AS perc_in_applicable,
  ROUND(COUNTIF(CAST(label_score AS NUMERIC) = 1) * 100 / COUNT(0), 2) AS perc_in_all_sites
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.label.score') AS label_score
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
