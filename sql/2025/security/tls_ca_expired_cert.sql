#standardSQL
# Section: Transport Security - Certificate Authority
# Question: How many certificates are expired?
# Note: currently includes HTTP (i.e., pages with no issuer)
SELECT
  client,
  issuer,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_https_pages,
  COUNTIF(CAST(valid_timestamp AS INT64) < 1751407200) AS freq,
  SAFE_DIVIDE(
    COUNTIF(CAST(valid_timestamp AS INT64) < 1751407200),
    SUM(COUNT(0)) OVER (PARTITION BY client)
  ) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS request_host,
    JSON_VALUE(payload, '$._securityDetails.validTo') AS valid_timestamp,
    JSON_VALUE(payload, '$._securityDetails.issuer') AS issuer
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01'
    AND is_root_page
    AND is_main_document
  GROUP BY
    client,
    request_host,
    valid_timestamp,
    issuer
)
GROUP BY
  client,
  issuer
ORDER BY
  pct DESC;

