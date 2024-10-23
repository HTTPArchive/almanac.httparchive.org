#standardSQL
#Distribution of CA issuers for all pages
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
    cert_issuer AS issuer
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    firstHtml AND
    cert_issuer IS NOT NULL
  GROUP BY
    client,
    request_host,
    cert_issuer
)
GROUP BY
  client,
  issuer
ORDER BY
  pct DESC
