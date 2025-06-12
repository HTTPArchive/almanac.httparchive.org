#standardSQL
# Distribution of TLS versions on all TLS-enabled requests
SELECT
  client,
  tls_version,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_hosts,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS host,
    IFNULL(JSON_EXTRACT_SCALAR(payload, '$._tls_version'), JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol')) AS tls_version
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    STARTS_WITH(url, 'https')
)
WHERE
  tls_version IS NOT NULL
GROUP BY
  client,
  tls_version
ORDER BY
  client,
  pct DESC
