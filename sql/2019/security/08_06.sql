#standardSQL
# 08_06: Cipher suites supporting forward secrecy
SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(REGEXP_CONTAINS(key_exchange, r'DHE') OR protocol = 'TLS 1.3') AS forward_secrecy_count,
  COUNT(0) AS total,
  ROUND(COUNTIF(REGEXP_CONTAINS(key_exchange, r'DHE') OR protocol = 'TLS 1.3') * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX,
    JSON_EXTRACT(payload, '$._securityDetails.keyExchange') AS key_exchange,
    JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol') AS protocol
  FROM
    `httparchive.requests.2019_07_01_*`)
WHERE
  protocol IS NOT NULL
GROUP BY
  client
