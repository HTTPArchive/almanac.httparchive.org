#standardSQL
# Distribution of cache TTL Lighthouse scores
SELECT 
  _TABLE_SUFFIX AS client,
  JSON_EXTRACT_SCALAR(report, "$.audits.uses-long-cache-ttl.score") AS caching_score,
  COUNT(0) AS num_pages,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct_pages
FROM 
  `httparchive.lighthouse.2020_08_01_*` 
GROUP BY 
  client,
  caching_score
ORDER BY 
  client, 
  caching_score ASC
