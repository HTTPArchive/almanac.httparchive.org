#standardSQL
# 08_02: Distribution of issuers
SELECT
  client,
  issuer,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  (SELECT _TABLE_SUFFIX AS client, JSON_EXTRACT_SCALAR(payload, '$._securityDetails.issuer') AS issuer FROM `httparchive.requests.2019_07_01_*`)
WHERE
  issuer IS NOT NULL
GROUP BY
  client,
  issuer
ORDER BY
  freq / total DESC
