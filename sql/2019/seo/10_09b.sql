#standardSQL
# 10_09b: image alt attribute usage
SELECT
  COUNTIF(img_alt) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(img_alt) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') = '1' AS img_alt
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
