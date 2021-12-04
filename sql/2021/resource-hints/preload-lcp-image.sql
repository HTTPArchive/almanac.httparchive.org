#standardSQL
# Distribution of Lighthouse scores for the 'Preload LCP image' audit


SELECT
  JSON_EXTRACT_SCALAR(report, "$.audits.preload-lcp-image.score") AS score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM
  `httparchive.lighthouse.2021_07_01_mobile`
GROUP BY
  score
ORDER BY
  score
