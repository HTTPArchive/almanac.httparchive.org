#standardSQL
# 21_13: Distribution of Lighthouse scores for the 'Defer offscreen images' audit
SELECT
  JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.score") AS score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY 0) AS pct
FROM
  `httparchive.lighthouse.2020_08_01_mobile`
GROUP BY
  score
ORDER BY
  score
