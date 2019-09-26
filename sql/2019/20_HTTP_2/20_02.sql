#standardSQL
# 20.2 - Measure of all HTTP versions (0.9, 1.0, 1.1, 2, QUIC) for main page of all sites, and for HTTPS sites. Table for last crawl.
SELECT 
  _TABLE_SUFFIX AS client,
  JSON_EXTRACT_SCALAR(payload, "$._protocol") AS protocol,
  COUNT(*) AS num_pages,
  SUM(IF(url LIKE "https://%", 1, 0)) AS num_https_pages
FROM 
   `httparchive.requests.2019_07_01_*`
WHERE
   JSON_EXTRACT_SCALAR(payload, "$._is_base_page") = "true"
GROUP BY
  client,
  protocol
ORDER BY 
  client,
  protocol
