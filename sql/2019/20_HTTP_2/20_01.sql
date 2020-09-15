#standardSQL
# 20.01 - Adoption of HTTP/2 by site and requests
SELECT 
  client,
  firstHtml, 
  JSON_EXTRACT_SCALAR(payload, "$._protocol") AS http_version, 
  COUNT(*) AS num_requests,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM 
  `httparchive.almanac.requests` 
GROUP BY
  client,
  firstHtml,
  http_version
ORDER BY 
  client,
  firstHtml,
  http_version
