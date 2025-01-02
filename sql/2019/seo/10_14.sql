#standardSQL
# 10_14: Descriptive link text usage
SELECT
  COUNTIF(link_text) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(link_text) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.link-text.score') = '1' AS link_text
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
