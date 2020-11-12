#standardSQL
# Distribution of bytes wasted (absence of adequate caching) from Lighthouse
SELECT 
  _TABLE_SUFFIX AS client,
  ROUND(CAST(JSON_EXTRACT_SCALAR(report, "$.audits.uses-long-cache-ttl.details.summary.wastedBytes")as numeric)/1024/1024) mbyte_savings,
  COUNT(*) num_pages,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct_pages       
FROM 
  `httparchive.lighthouse.2020_08_01_*`
WHERE
  JSON_EXTRACT_SCALAR(report, "$.audits.uses-long-cache-ttl.score") != "1"
GROUP BY 
  client,
  mbyte_savings
ORDER BY 
  client,
  mbyte_savings ASC
