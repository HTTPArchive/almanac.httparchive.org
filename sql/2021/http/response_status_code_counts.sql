# standardSQL
# HTTP Status Codes popularity.

SELECT
  client,
  LEFT(CAST(status AS STRING), 1) AS status_group,
  status,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT url LIMIT 5), ' ') AS sample_urls
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client,
  status
ORDER BY
  num_requests DESC,
  status
LIMIT 1000
