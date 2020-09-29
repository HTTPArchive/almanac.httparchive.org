#standardSQL
# Distribution of all ciphers for all requests
SELECT
  client,
  cipher,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, '$._securityDetails.cipher') AS cipher,
  FROM
    `httparchive.requests.2020_08_01_*`)
WHERE
  cipher IS NOT NULL
GROUP BY
  client,
  cipher
ORDER BY
  pct DESC
