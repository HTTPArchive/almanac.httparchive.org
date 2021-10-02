#standardSQL
  # compression_formats_text_responses.sql : What compression formats are being used (gzip, brotli, etc) on text responses
SELECT
  client,
    IF(resp_content_encoding = "gzip", "Gzip", IF(resp_content_encoding = "br", "Brotli", IF(resp_content_encoding = "", "no text compression", "other"))) AS compression_type,
  COUNT(0) AS num_requests,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
  AND 
  (resp_content_type LIKE 'text/%' 
  OR resp_content_type LIKE '%svg+xml%' 
  OR resp_content_type LIKE '%ttf%' 
  OR resp_content_type LIKE '%xml%'
  OR resp_content_type LIKE '%otf%'
  OR resp_content_type IN ('application/javascript', 'application/x-javascript', 'application/json')
  )
GROUP BY
  client,
  compression_type
ORDER BY
  num_requests DESC