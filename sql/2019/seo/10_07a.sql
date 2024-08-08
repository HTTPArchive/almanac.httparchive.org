#standardSQL
# 10_07a: <title> and <meta description> present
SELECT
  COUNTIF(has_title) AS doc_title,
  COUNTIF(has_meta_description) AS meta_description,
  COUNTIF(has_title AND has_meta_description) AS both,
  COUNT(0) AS total,
  ROUND(COUNTIF(has_title) * 100 / COUNT(0), 2) AS pct_title,
  ROUND(COUNTIF(has_meta_description) * 100 / COUNT(0), 2) AS pct_desc,
  ROUND(COUNTIF(has_title AND has_meta_description) * 100 / COUNT(0), 2) AS pct_both
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.document-title.score') = '1' AS has_title,
    JSON_EXTRACT_SCALAR(report, '$.audits.meta-description.score') = '1' AS has_meta_description
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
