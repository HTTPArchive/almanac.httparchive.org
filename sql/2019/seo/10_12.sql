#standardSQL
# 10_12: robots.txt
SELECT
  JSON_EXTRACT_SCALAR(report, '$.audits.robots-txt.score') AS score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY 0), 2) AS pct
FROM
  `httparchive.lighthouse.2019_07_01_mobile`
GROUP BY
  score
