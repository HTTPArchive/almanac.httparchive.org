#standardSQL
# Top 100 third party requests by request volume
SELECT
  requestUrl,
  COUNT(*) AS totalRequests,
  SUM(requestBytes) AS totalBytes,
  ROUND(COUNT(*) * 100 / MAX(t2.totalRequestCount), 2) AS percentRequestCount
FROM (
  SELECT
      url AS requestUrl,
      respBodySize AS requestBytes
    FROM
      `httparchive.almanac.summary_requests`
) t1, (
  SELECT COUNT(*) AS totalRequestCount FROM `httparchive.almanac.summary_requests`
) t2
GROUP BY
  requestUrl
ORDER BY
  totalRequests DESC
LIMIT 100

