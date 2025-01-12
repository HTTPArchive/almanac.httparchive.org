#standardSQL
# Section: Transport Security - Protocol Versions
# Question: Which TLS versions are most common on all TLS-enabled web pages?
SELECT
  client,
  tls_version,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_https_pages,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    IFNULL(JSON_VALUE(payload, '$._tls_version'), JSON_VALUE(payload, '$._securityDetails.protocol')) AS tls_version
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document AND
    STARTS_WITH(url, 'https')
)
WHERE
  tls_version IS NOT NULL
GROUP BY
  client,
  tls_version
ORDER BY
  pct DESC
