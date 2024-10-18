#standardSQL
# compression_formats_text_responses.sql : What compression formats are being used (gzip, brotli, etc) on text responses
SELECT
  client,
  CASE
    WHEN resp_content_encoding = 'gzip' THEN 'Gzip'
    WHEN resp_content_encoding = 'br' THEN 'Brotli'
    WHEN resp_content_encoding = '' THEN 'no text compression'
    ELSE 'other'
  END AS compression_type,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND (
    resp_content_type LIKE 'text/%' OR
    resp_content_type LIKE '%ttf%' OR
    resp_content_type LIKE '%xml%' OR
    resp_content_type LIKE '%otf%' OR
    resp_content_type IN ('application/javascript', 'application/x-javascript', 'application/json')
  )
GROUP BY
  client,
  compression_type
ORDER BY
  num_requests DESC
