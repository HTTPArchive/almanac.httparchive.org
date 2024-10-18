#standardSQL
# % of pages with a valid html lang attribute
SELECT
  client,
  COUNT(0) AS total,
  COUNTIF(valid_lang) AS valid_lang,
  COUNTIF(has_lang) AS has_lang,
  COUNTIF(has_lang) / COUNT(0) AS pct_has_of_total,
  COUNTIF(valid_lang) / COUNT(0) AS pct_valid_of_total
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(report, "$.audits['html-has-lang'].score") = '1' AS has_lang,
    JSON_EXTRACT_SCALAR(report, "$.audits['html-lang-valid'].score") = '1' AS valid_lang
  FROM
    `httparchive.lighthouse.2022_06_01_*`
)
GROUP BY
  client
ORDER BY
  client
