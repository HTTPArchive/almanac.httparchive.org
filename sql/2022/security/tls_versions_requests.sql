#standardSQL
# Distribution of TLS versions on all TLS-enabled requests
SELECT
  client,
  tls_version,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_https_hosts,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS host,
    IFNULL(tls_version, cert_protocol) AS tls_version
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
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
