#standardSQL
# 15.05 - Distribution of Text Based Compression Lighthouse Scores
SELECT
  _TABLE_SUFFIX AS client,
  JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.score") AS text_compression_score,
  COUNT(0) AS num_pages,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct_pages
FROM
  `httparchive.lighthouse.2019_07_01_*`
GROUP BY
  client,
  text_compression_score
ORDER BY
  client,
  text_compression_score ASC
