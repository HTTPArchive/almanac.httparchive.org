#standardSQL
# Top 100 third party requests by request volume
SELECT
  requestUrl,
  COUNT(*) AS totalRequests,
  SUM(requestBytes) AS totalBytes
FROM (
  SELECT
      url AS requestUrl,
      respBodySize AS requestBytes
    FROM
      `httparchive.almanac.summary_requests`
)
GROUP BY
  requestUrl
ORDER BY
  totalRequests DESC
LIMIT 1000

