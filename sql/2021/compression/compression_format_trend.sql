#standardSQL
  # compression_format_trend.sql : What compression formats are being used (gzip, brotli, etc)
SELECT
  EXTRACT(YEAR FROM date) AS year,
  client,
  IF(resp_content_encoding = "gzip", "Gzip", IF(resp_content_encoding = "br", "Brotli", IF(resp_content_encoding = "", "no text compression", "other"))) AS compression_type,
  COUNT(0) AS num_requests
FROM
  (
    SELECT date, client, resp_content_encoding FROM `httparchive.almanac.requests_2020` WHERE DATE IN ('2020-08-01', '2019-07-01')
    UNION ALL
    SELECT date, client, resp_content_encoding FROM `httparchive.almanac.requests`
  )

GROUP BY
  year,
  client,
  compression_type
ORDER BY
  compression_type DESC
