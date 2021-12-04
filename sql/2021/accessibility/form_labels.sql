#standardSQL
# Sites that have associated labels for their form elements
SELECT
  COUNT(0) AS total_sites,
  COUNTIF(label_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(label_score AS NUMERIC) = 1) AS total_sufficient,
  COUNTIF(CAST(label_score AS NUMERIC) = 1) / COUNTIF(label_score IS NOT NULL) AS perc_in_applicable
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.label.score') AS label_score
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
)
