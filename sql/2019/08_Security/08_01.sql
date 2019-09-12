#standardSQL
# 08_01: Distribution of TLS versions
SELECT 
  _TABLE_SUFFIX AS client,
  DISTINCT(JSON_EXTRACT_SCALAR(payload, '$._tls_version')) as tls_version,
  ROUND(COUNT(0) / (SELECT COUNT(0) FROM `httparchive.requests.2019_07_01_*` WHERE JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL), 2) pct_tls_version
FROM 
  `httparchive.requests.2019_07_01_*`
WHERE
  JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL 
GROUP BY
  client, tls_version
