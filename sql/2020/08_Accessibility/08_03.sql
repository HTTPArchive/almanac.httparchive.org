#standardSQL
# 08_03: % of mobile sites with a valid html lang attribute
SELECT
  COUNT(0) AS total,
  COUNTIF(valid_lang) AS valid_lang,
  COUNTIF(has_lang) AS has_lang,
  ROUND(COUNTIF(has_lang) * 100 / COUNT(0), 2) AS pct_has_of_total,
  ROUND(COUNTIF(valid_lang) * 100 / COUNT(0), 2) AS pct_valid_of_total,
  ROUND(COUNTIF(valid_lang) * 100 / COUNTIF(has_lang), 2) AS pct_valid_of_has
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, "$.audits['html-has-lang'].score") = '1' AS has_lang,
    JSON_EXTRACT_SCALAR(report, "$.audits['html-valid-lang'].score") = '1' AS valid_lang
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`)
