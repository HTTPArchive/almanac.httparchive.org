#standardSQL
# Distribution of all ciphers for all requests
SELECT
  client,
  cipher,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_https_requests,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    cert_cipher AS cipher
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01'
)
WHERE
  cipher IS NOT NULL
GROUP BY
  client,
  cipher
ORDER BY
  pct DESC
