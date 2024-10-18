#standardSQL
# Distribution of TLS versions on all TLS-enabled web pages
SELECT
  client,
  tls_version,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_pages,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    IFNULL(JSON_EXTRACT_SCALAR(payload, '$._tls_version'), JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol')) AS tls_version
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    STARTS_WITH(url, 'https') AND
    firstHtml
)
WHERE
  tls_version IS NOT NULL
GROUP BY
  client,
  tls_version
ORDER BY
  pct DESC
