#standardSQL

# image alt attribute usage
SELECT
  # alt score
  COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') = '1') AS num_passing,
  ROUND(COUNTIF(JSON_EXTRACT_SCALAR(report, '$.audits.image-alt.score') = '1') * 100 / COUNT(0), 2) AS pct_passing
FROM
  `httparchive.lighthouse.2019_07_01_mobile`
