#standardSQL
# 22_HTTP_2 - Count of HTTP/2 Sites using HTTP/2 Push
SELECT 
  client,
  COUNT(DISTINCT page) AS num_pages
FROM (

  SELECT 
    client,
    page
  FROM 
    `httparchive.almanac.requests` 
  WHERE 
    JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2"
    AND JSON_EXTRACT_SCALAR(payload, "$._was_pushed") = "1"
    AND date='2020-08-01'
)
GROUP BY
  client