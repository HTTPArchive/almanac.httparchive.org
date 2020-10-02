#standardSQL
# Cipher suites supporting forward secrecy for all requests
SELECT
  client,
  COUNTIF(REGEXP_CONTAINS(key_exchange, r'(?i)DHE') OR protocol = 'TLS 1.3') AS forward_secrecy_count,
  COUNT(0) AS total,
  COUNTIF(REGEXP_CONTAINS(key_exchange, r'(?i)DHE') OR protocol = 'TLS 1.3') / COUNT(0) AS pct
FROM (
  SELECT
    client,
    JSON_EXTRACT(payload, '$._securityDetails.keyExchange') AS key_exchange,
    JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol') AS protocol
  FROM
   `httparchive.almanac.requests`)
WHERE
  protocol IS NOT NULL
GROUP BY
  client
ORDER BY
  pct DESC
