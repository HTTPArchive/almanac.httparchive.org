# standardSQL
# Distribution of TLS versions by HHTP Version
SELECT
  client,
  http_version_category,
  tls_version,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM (
  SELECT
    client,
    page,
    protocol,
    CASE
      WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/2+'
      WHEN LOWER(protocol) = 'http/2' OR LOWER(protocol) = 'http/3' THEN 'HTTP/2+'
      WHEN protocol IS NULL THEN 'Unknown'
      ELSE UPPER(protocol)
    END AS http_version_category,
    CASE
      WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/3'
      WHEN protocol IS NULL THEN 'Unknown'
      ELSE UPPER(protocol)
    END AS http_version,
    IFNULL(tls_version, cert_protocol) AS tls_version
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    STARTS_WITH(url, 'https') AND
    firstHtml
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  WHERE
    STARTS_WITH(url, 'https')
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  http_version_category,
  tls_version,
  total
ORDER BY
  pct DESC
