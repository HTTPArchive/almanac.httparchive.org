# standardSQL
# Pages loading most number of requests
SELECT
  client,
  page,
  COUNT(0) AS numberOfRequests,
  SUM(respHeadersSize) / 1024 AS ResponseHeaderSizeKiB,
  SUM(respBodySize) / 1024 AS ResponseBodySizeKiB
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client,
  page
ORDER BY
  COUNT(0) DESC
LIMIT 100
