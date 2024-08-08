#standardSQL
# Cipher suites supporting forward secrecy for all requests
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(REGEXP_CONTAINS(key_exchange, r'(?i)DHE') OR protocol = 'TLS 1.3') AS forward_secrecy_count,
  COUNTIF(REGEXP_CONTAINS(key_exchange, r'(?i)DHE') OR protocol = 'TLS 1.3') / COUNT(0) AS pct
FROM (
  SELECT
    client,
    JSON_EXTRACT(payload, '$._securityDetails.keyExchange') AS key_exchange,
    JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol') AS protocol
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01'
)
WHERE
  protocol IS NOT NULL
GROUP BY
  client
ORDER BY
  client,
  pct DESC
