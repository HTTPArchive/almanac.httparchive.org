#standardSQL
# 20.04 - Number of HTTP sites which return upgrade HTTP header containing H2
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
  getUpgradeHeader(payload) as upgrade,
  COUNT(*) AS num_requests
FROM 
  `httparchive.requests.2019_07_01_*`
WHERE
  url LIKE "http://%"
GROUP BY
  client,
  is_base_page,
  upgrade
