#standardSQL
# 22_HTTP_2 - Average number of HTTP/2 Pushed Resources and Average Bytes
SELECT 
  client,
  COUNT(DISTINCT page) AS num_pages,
  ROUND(AVG(num_requests),2) AS avg_pushed_requests,
  ROUND(AVG(kb_transfered),2) AS avg_kb_transfered
FROM (

SELECT 
    client,
    page,
    SUM(CAST(JSON_EXTRACT_SCALAR(payload, "$._bytesIn") AS INT64)/1024) AS kb_transfered,
    COUNT(*) AS num_requests
  FROM 
    `httparchive.almanac.requests` 
  WHERE 
    JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2"
    AND JSON_EXTRACT_SCALAR(payload, "$._was_pushed") = "1"
    AND date='2020-08-01'
  GROUP BY 
    client,
    page
)
GROUP BY
  client
