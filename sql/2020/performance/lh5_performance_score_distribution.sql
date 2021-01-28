#standardSQL
# Distribution of LH5 performance score.

SELECT
  JSON_EXTRACT_SCALAR(report, '$.categories.performance.score') AS score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM
  `httparchive.lighthouse.2019_07_01_mobile`
GROUP BY
  score
ORDER BY
  score
