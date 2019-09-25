#standardSQL
# 20.05 - Number of HTTPS sites using HTTP/2 which return upgrade HTTP header containing h2
CREATE TEMPORARY FUNCTION getUpgradeHeader(payload STRING)
RETURNS STRING
LANGUAGE js AS """
  try {
    var $ = JSON.parse(payload);
    var headers = $.response.headers;
    var st = headers.find(function(e) { 
      return e['name'].toLowerCase() === 'upgrade'
    });
    return st['value'];
  } catch (e) {
    return '';
  }
""";

SELECT 
  _TABLE_SUFFIX AS client,
  JSON_EXTRACT_SCALAR(payload, "$._is_base_page") AS is_base_page,  
  COUNT(*) AS num_requests
FROM 
  `httparchive.requests.2019_07_01_*`
WHERE
  url LIKE "https://%"
  AND JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2"
  AND getUpgradeHeader(payload) LIKE "%h2%"
GROUP BY
  client,
  is_base_page
