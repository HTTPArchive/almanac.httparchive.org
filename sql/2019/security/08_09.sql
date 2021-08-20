#standardSQL
# 08_09 Legacy cipher suites
# Distribution of all ciphers
SELECT
  _TABLE_SUFFIX AS client,
  JSON_EXTRACT_SCALAR(payload, '$._securityDetails.cipher') AS cipher,
  COUNT(0) AS cipher_count,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.requests.2019_07_01_*`
GROUP BY
  client,
  cipher
HAVING
  cipher IS NOT NULL
ORDER BY
  cipher_count DESC
