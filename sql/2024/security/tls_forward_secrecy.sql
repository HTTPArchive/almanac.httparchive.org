#standardSQL
# Section: Transport Security - Cipher Suites
# Question: How many used cipher suites support forward secrecy for all requests?
# Note: Large query (40+TB)
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(REGEXP_CONTAINS(key_exchange, r'(?i)DHE') OR protocol = 'TLS 1.3') AS forward_secrecy_count,
  COUNTIF(REGEXP_CONTAINS(key_exchange, r'(?i)DHE') OR protocol = 'TLS 1.3') / COUNT(0) AS pct
FROM (
  SELECT
    client,
    JSON_VALUE(payload, '$._securityDetails.keyExchange') AS key_exchange,
    JSON_VALUE(payload, '$._securityDetails.protocol') AS protocol
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)
WHERE
  protocol IS NOT NULL
GROUP BY
  client
ORDER BY
  client,
  pct DESC
