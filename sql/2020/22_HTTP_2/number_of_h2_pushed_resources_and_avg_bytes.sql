# standardSQL
# Number of HTTP/2 Pushed Resources and Average Bytes
SELECT 
  client,
  COUNT(DISTINCT page) AS num_pages,
  APPROX_QUANTILES(num_requests, 1000)[OFFSET(500)] AS median_pushed_requests,
  APPROX_QUANTILES(kb_transfered, 1000)[OFFSET(500)] AS median_kb_transfered,
FROM (
 SELECT 
    percentile,
    client,
    page,
    SUM(CAST(JSON_EXTRACT_SCALAR(payload, "$._bytesIn") AS INT64)/1024) AS kb_transfered,
    COUNT(0) AS num_requests
  FROM 
    `httparchive.almanac.requests`,
    UNNEST([10, 25, 50, 75, 90]) AS percentile
  WHERE 
    date='2020-08-01' AND
    JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2" AND
    JSON_EXTRACT_SCALAR(payload, "$._was_pushed") = "1"
  GROUP BY 
    percentile,
    client,
    page
)
GROUP BY
  client
