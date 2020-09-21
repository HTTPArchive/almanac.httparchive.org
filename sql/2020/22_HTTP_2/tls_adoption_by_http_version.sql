# standardSQL
# Distribution of TLS versions
SELECT
  client,
  http_version,
  tls_version,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client), 4) pct
FROM (
  SELECT
    client,
    JSON_EXTRACT_SCALAR(payload, '$._protocol') as http_version,
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') AS tls_version
  FROM `httparchive.almanac.requests` WHERE date='2020-08-01'
  )
WHERE
  http_version IS NOT NULL AND  
  tls_version IS NOT NULL
GROUP BY
  client,
  http_version,
  tls_version
ORDER BY
  freq / total DESC
