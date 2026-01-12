#standardSQL
# Section: Transport Security - Certificate Authority
# Question: What is the distribution of CA issuers for all pages over time?
# Note: currently includes HTTP (i.e., pages with no issuer)
SELECT
  date,
  client,
  issuer,
  SUM(COUNT(0)) OVER (PARTITION BY client, date) AS total_https_pages,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, date) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS request_host,
    JSON_VALUE(payload, '$._securityDetails.issuer') AS issuer,
    date
  FROM
    `httparchive.crawl.requests`
  WHERE
    (date = '2025-07-01' OR date = '2024-06-01' OR date = '2023-07-01' OR date = '2022-06-01' OR date = '2021-07-01' OR date = '2020-08-01') AND
    is_root_page AND
    is_main_document
  GROUP BY
    client,
    request_host,
    issuer,
    date
)
GROUP BY
  client,
  issuer,
  date
ORDER BY
  date DESC
