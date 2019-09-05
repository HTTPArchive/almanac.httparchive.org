#standardSQL
# 20.10 - Count of HTTP/2 Sites using HTTP/2 Push
SELECT 
  client,
  COUNT(DISTINCT page) AS num_pages
FROM (

  SELECT 
    _TABLE_SUFFIX AS client,
    page
  FROM 
    `httparchive.requests.2019_07_01_*` 
  WHERE 
    JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2"
    AND 
    JSON_EXTRACT_SCALAR(payload, "$._was_pushed") = "1"
)
GROUP BY
  client
