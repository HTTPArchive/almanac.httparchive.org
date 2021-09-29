#standardSQL
# 20.12 - Average number of HTTP/2 Pushed Resources and Average Bytes by Content type
SELECT
  client,
  content_type,
  COUNT(DISTINCT page) AS num_pages,
  ROUND(AVG(num_requests), 2) AS avg_pushed_requests,
  ROUND(AVG(kb_transfered), 2) AS avg_kb_transfered
FROM (

  SELECT
    client,
    page,
    JSON_EXTRACT_SCALAR(payload, "$._contentType") AS content_type,
    SUM(CAST(JSON_EXTRACT_SCALAR(payload, "$._bytesIn") AS INT64) / 1024) AS kb_transfered,
    COUNT(0) AS num_requests
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2" AND
    JSON_EXTRACT_SCALAR(payload, "$._was_pushed") = "1"
  GROUP BY
    client,
    page,
    content_type
)
GROUP BY
  client,
  content_type
