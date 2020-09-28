#standardSQL
# Distribution of TLS versions on all TLS-enabled web pages
SELECT
  client,
  tls_version,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct,
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') AS tls_version
  FROM
    `httparchive.requests.2020_08_01_*`
  JOIN
    `httparchive.summary_requests.2020_08_01_*`
  USING (_TABLE_SUFFIX, url)
  WHERE firstHtml = true
)
WHERE
  tls_version IS NOT NULL
GROUP BY
  client,
  tls_version
ORDER BY
  pct DESC
