#standardSQL
# Distribution of Lighthouse scores for the 'Preload Fonts' audit


SELECT
  JSON_EXTRACT_SCALAR(report, "$.audits.preload-fonts.score") AS score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM
  `httparchive.lighthouse.2021_07_01_mobile`
GROUP BY
  score
ORDER BY
  score
