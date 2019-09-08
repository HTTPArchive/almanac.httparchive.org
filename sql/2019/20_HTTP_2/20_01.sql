#standardSQL
# 20.01 - Adoption of HTTP/2 by site and requests
SELECT 
 _TABLE_SUFFIX AS client,
  JSON_EXTRACT_SCALAR(payload, "$._is_base_page") AS is_base_page, 
  JSON_EXTRACT_SCALAR(payload, "$._protocol") AS http_version, 
  COUNT(*) AS num_requests,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM 
  `httparchive.requests.2019_07_01_*` 
GROUP BY
  client,
  is_base_page,
  http_version
ORDER BY 
  client,
  is_base_page,
  http_version
