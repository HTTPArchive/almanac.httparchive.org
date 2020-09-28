#standardSQL
#Distribution of CA issuers for all pages
SELECT
  client,
  issuer,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    NET.HOST(url) AS request_host,
    ANY_VALUE(JSON_EXTRACT_SCALAR(payload, '$._securityDetails.issuer')) AS issuer
  FROM
    `httparchive.requests.2020_08_01_*`
  WHERE NET.HOST(page) = NET.HOST(url) AND JSON_EXTRACT_SCALAR(payload, '$._securityDetails.issuer') IS NOT NULL
  GROUP BY client, request_host)
GROUP BY
  client,
  issuer
ORDER BY
  pct DESC
