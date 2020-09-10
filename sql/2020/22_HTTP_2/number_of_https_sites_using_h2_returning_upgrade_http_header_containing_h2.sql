#standardSQL
# 22_HTTP_2 - Number of HTTPS sites using HTTP/2 which return upgrade HTTP header containing h2
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
  client,
  firstHtml,  
  COUNT(*) AS num_requests
FROM 
  `httparchive.almanac.requests`
WHERE
  url LIKE "https://%"
  AND JSON_EXTRACT_SCALAR(payload, "$._protocol") = "HTTP/2"
  AND getUpgradeHeader(payload) LIKE "%h2%"
  AND date='2020-08-01'
GROUP BY
  client,
  firstHtml