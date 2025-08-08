#standardSQL
# Section: Transport Security - Protocol Versions
# Question: What is the distribution of TLS versions on all TLS-enabled requests?
# Note: Query is large (40TB)
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
    IFNULL(JSON_VALUE(payload, '$._tls_version'), JSON_VALUE(payload, '$._securityDetails.protocol')) AS tls_version
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
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
