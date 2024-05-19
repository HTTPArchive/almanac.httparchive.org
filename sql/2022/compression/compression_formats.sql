#standardSQL
# compression_formats.sql : What compression formats are being used (gzip, brotli, etc)
SELECT
  client,
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
  resp_content_encoding
ORDER BY
  num_requests DESC
