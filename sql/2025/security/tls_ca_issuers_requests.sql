#standardSQL
# Section: Transport Security - Certificate Authority
# Question: What is the distribution of CA issuers for all (top-level) requests?
# Note: original query was without is_main_document but due to the port to the tables it suddently took 50+TB instead of 20GB?!
SELECT
  client,
  issuer,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_https_requests,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    JSON_VALUE(payload, '$._securityDetails.issuer') AS issuer
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    is_main_document
)
WHERE
  issuer IS NOT NULL
GROUP BY
  client,
  issuer
ORDER BY
  pct DESC
