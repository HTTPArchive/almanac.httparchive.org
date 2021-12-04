#standardSQL
#Distribution of CA issuers for all pages
SELECT
  client,
  issuer,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_pages,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(url) AS request_host,
    ANY_VALUE(JSON_EXTRACT_SCALAR(payload, '$._securityDetails.issuer')) AS issuer
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    NET.HOST(page) = NET.HOST(url) AND
    JSON_EXTRACT_SCALAR(payload, '$._securityDetails.issuer') IS NOT NULL
  GROUP BY client, request_host)
GROUP BY
  client,
  issuer
ORDER BY
  pct DESC
