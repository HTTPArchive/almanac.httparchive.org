#standardSQL
# Top 100 third party requests by request volume
SELECT
  requestUrl,
  COUNT(0) AS totalRequests,
  SUM(requestBytes) AS totalBytes,
  ROUND(COUNT(0) * 100 / MAX(t2.totalRequestCount), 2) AS percentRequestCount
FROM (
  SELECT
    url AS requestUrl,
    respBodySize AS requestBytes
  FROM
    `httparchive.almanac.summary_requests`
  WHERE
    date = '2019-07-01'
),
(
  SELECT COUNT(0) AS totalRequestCount FROM `httparchive.almanac.summary_requests` WHERE date = '2019-07-01'
)
GROUP BY
  requestUrl
ORDER BY
  totalRequests DESC
LIMIT 100

