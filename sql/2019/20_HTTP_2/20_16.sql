#standardSQL
# 20.04a_5a_6a - Detailed alt-svc headers
CREATE TEMPORARY FUNCTION getAltSvcHeader(payload STRING)
RETURNS STRING
LANGUAGE js AS """
  try {
    var $ = JSON.parse(payload);
    var headers = $.response.headers;
    var st = headers.find(function(e) { 
      return e['name'].toLowerCase() === 'alt-svc'
    });
    return st['value'];
  } catch (e) {
    return '';
  }
""";

SELECT 
  _TABLE_SUFFIX AS client,
  JSON_EXTRACT_SCALAR(payload, "$._is_base_page") AS is_base_page,  
  JSON_EXTRACT_SCALAR(payload, "$._protocol") AS protocol,
  getAltSvcHeader(payload) AS altsvc,
  COUNT(*) AS num_requests
FROM 
  `httparchive.requests.2019_07_01_*`
GROUP BY
  client,
  is_base_page,
  protocol,
  altsvc
