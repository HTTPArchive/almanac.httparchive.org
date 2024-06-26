#standardSQL
# 04_13: Lighthouse img alt
SELECT
  COUNTIF(pass) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(pass) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') = '1' AS pass
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
