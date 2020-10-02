#standardSQL
# Distribution of TLS versions on all TLS-enabled requests
SELECT
  client,
  tls_version,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') AS tls_version
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01')
WHERE
  tls_version IS NOT NULL
GROUP BY
  client,
  tls_version
ORDER BY
  pct DESC
