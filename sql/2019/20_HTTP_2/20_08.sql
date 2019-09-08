#standardSQL
# 20.08 - Count of HTTP/2 Sites Grouped By Server
CREATE TEMPORARY FUNCTION getServerHeader(payload STRING)
RETURNS STRING
LANGUAGE js AS """
  try {
    var $ = JSON.parse(payload);
    var headers = $.response.headers;
    // Find server header
    var st = headers.find(function(e) { 
      return e['name'].toLowerCase() === 'server'
    });
    // Remove everything after / in the server header value and return
    return st['value'].split("/")[0]; 
  } catch (e) {
    return '';
  }
""";

SELECT 
 _TABLE_SUFFIX AS client,
  getServerHeader(payload) AS server_header,
  COUNT(*) AS num_pages,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM 
  `httparchive.requests.2019_07_01_*` 
WHERE
  JSON_EXTRACT_SCALAR(payload, "$._is_base_page")  = "true"
  AND JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2"
GROUP BY
  client,
  server_header
ORDER BY num_pages DESC
