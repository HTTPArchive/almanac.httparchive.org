#standardSQL
  # compression_format_trend.sql : What compression formats are being used (gzip, brotli, etc)
SELECT
  EXTRACT(YEAR FROM date) AS year,
  client,
  CASE
    WHEN resp_content_encoding = 'gzip' THEN 'Gzip'
    WHEN resp_content_encoding = 'br' THEN 'Brotli'
    WHEN resp_content_encoding = '' THEN 'no text compression'
    ELSE 'other'
  END AS compression_type,
  COUNT(0) AS num_requests
FROM
  (
    SELECT date, client, resp_content_encoding FROM `httparchive.almanac.requests` WHERE DATE IN ('2021-07-01', '2020-08-01', '2019-07-01')
  )

GROUP BY
  year,
  client,
  compression_type
ORDER BY
  compression_type DESC
