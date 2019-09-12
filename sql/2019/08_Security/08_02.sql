#standardSQL
# 08_02: Unique issuer
SELECT 
  DISTINCT(JSON_EXTRACT_SCALAR(payload, '$._securityDetails.issuer')) AS issuer,
  ROUND(count(0) / (SELECT COUNT(0) FROM `httparchive.requests.2019_07_01_*` WHERE JSON_EXTRACT(payload, '$._securityDetails') IS NOT NULL), 2) AS pct_issuer
FROM 
  `httparchive.requests.2019_07_01_*`
WHERE 
  JSON_EXTRACT(payload, '$._securityDetails') IS NOT NULL
GROUP BY 
  issuer
ORDER BY 
  pct DESC
