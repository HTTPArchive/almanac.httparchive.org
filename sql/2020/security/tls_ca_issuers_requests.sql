#standardSQL
# Distribution of CA issuers for all requests
SELECT
  client,
  issuer,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_requests,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    JSON_EXTRACT_SCALAR(payload, '$._securityDetails.issuer') AS issuer
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01'
)
WHERE
  issuer IS NOT NULL
GROUP BY
  client,
  issuer
ORDER BY
  pct DESC
