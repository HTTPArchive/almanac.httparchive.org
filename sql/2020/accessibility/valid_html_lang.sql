#standardSQL
# % of mobile sites with a valid html lang attribute
SELECT
  COUNT(0) AS total,
  COUNTIF(valid_lang) AS valid_lang,
  COUNTIF(has_lang) AS has_lang,
  COUNTIF(has_lang) / COUNT(0) AS pct_has_of_total,
  COUNTIF(valid_lang) / COUNT(0) AS pct_valid_of_total
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, "$.audits['html-has-lang'].score") = '1' AS has_lang,
    JSON_EXTRACT_SCALAR(report, "$.audits['html-lang-valid'].score") = '1' AS valid_lang
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`
)
