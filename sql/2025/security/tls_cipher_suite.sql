#standardSQL
# Section: Transport Security - Cipher suites
# Question: What is the distribution of all ciphers for all requests?
# Note: Query is large (43TB)
SELECT
  client,
  cipher,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_https_requests,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    JSON_VALUE(payload, '$._securityDetails.cipher') AS cipher
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)
WHERE
  cipher IS NOT NULL
GROUP BY
  client,
  cipher
ORDER BY
  pct DESC
