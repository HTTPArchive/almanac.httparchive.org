#standardSQL
# compression_by_content_type.sql : Compression methods for different content types

SELECT
  client,
  LOWER(mimeType) AS mimeType,
  resp_content_encoding,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01'
GROUP BY
  client,
  mimeType,
  resp_content_encoding
HAVING
  num_requests > 1000
ORDER BY
  num_requests DESC
