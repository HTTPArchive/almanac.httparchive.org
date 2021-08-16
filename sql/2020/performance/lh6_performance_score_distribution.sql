#standardSQL
# Distribution of LH6 performance score.

SELECT
  JSON_EXTRACT_SCALAR(report, '$.categories.performance.score') AS score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY 0) AS pct
FROM
  `httparchive.lighthouse.2020_09_01_mobile`
GROUP BY
  score
ORDER BY
  score
