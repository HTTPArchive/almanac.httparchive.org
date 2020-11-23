#standardSQL
# 21_11b: Distribution of Lighthouse scores for the 'Preload key requests' audit
SELECT
  JSON_EXTRACT_SCALAR(report, "$.audits.uses-rel-preload.score") AS score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM
  `httparchive.lighthouse.2020_08_01_mobile`
GROUP BY
  score
ORDER BY
  score