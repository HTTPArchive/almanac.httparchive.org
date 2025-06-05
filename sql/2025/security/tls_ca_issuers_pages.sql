#standardSQL
# Section: Transport Security - Certificate Authority
# Question: What is the distribution of CA issuers for all pages?
# Note: currently includes HTTP (i.e., pages with no issuer)
SELECT
  client,
  issuer,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_https_pages,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS request_host,
    JSON_VALUE(payload, '$._securityDetails.issuer') AS issuer
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document
  GROUP BY
    client,
    request_host,
    issuer
)
GROUP BY
  client,
  issuer
ORDER BY
  pct DESC
