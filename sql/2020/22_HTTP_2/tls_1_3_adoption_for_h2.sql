#standardSQL
# 22_HTTP_2 - Distribution of TLS versions
SELECT
  client,
  tls_version,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) pct
FROM
  (SELECT _TABLE_SUFFIX AS client, JSON_EXTRACT_SCALAR(payload, '$._tls_version') AS tls_version FROM `httparchive.requests.2020_07_01_*`)
WHERE
  tls_version IS NOT NULL
GROUP BY
  client,
  tls_version
ORDER BY
  freq / total DESC