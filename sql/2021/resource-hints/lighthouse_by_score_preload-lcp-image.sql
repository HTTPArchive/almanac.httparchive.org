#standardSQL
# Distribution of Lighthouse scores for the 'Preload LCP image' audit

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  JSON_EXTRACT_SCALAR(report, "$.audits.preload-lcp-image.score") AS score,
  COUNT(0) AS freq,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER()) AS pct
FROM
  `httparchive.lighthouse.2021_07_01_mobile`
GROUP BY
  score
ORDER BY
  score
