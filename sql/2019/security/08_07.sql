#standardSQL
# 08_07: Autheticated cipher suites
SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(REGEXP_CONTAINS(cipher, r'GCM|CCM|POLY1305')) AS authenticated_cipher_count,
  COUNT(0) AS total,
  ROUND(COUNTIF(REGEXP_CONTAINS(cipher, r'GCM|CCM|POLY1305')) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX,
    JSON_EXTRACT(payload, '$._securityDetails.cipher') AS cipher
  FROM
    `httparchive.requests.2019_07_01_*`)
WHERE
  cipher IS NOT NULL
GROUP BY
  client
