# standardSQL
# Distribution of TLS versions by HHTP Version
SELECT
  client,
  protocol,
  tls_version,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM (
  SELECT
    client,
    page,
    IF(JSON_EXTRACT_SCALAR(payload, '$._protocol') IN ('http/0.9', 'http/1.0', 'http/1.1', 'HTTP/2', 'QUIC', 'http/2+quic/46', 'HTTP/3'), JSON_EXTRACT_SCALAR(payload, '$._protocol'), 'other') AS protocol,
    IFNULL(JSON_EXTRACT_SCALAR(payload, '$._tls_version'), JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol')) AS tls_version
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    STARTS_WITH(url, 'https') AND
    firstHtml
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  WHERE
    STARTS_WITH(url, 'https')
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  protocol,
  tls_version,
  total
ORDER BY
  pct DESC
