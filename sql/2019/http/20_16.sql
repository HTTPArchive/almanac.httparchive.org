#standardSQL
# 20.16 - Detailed alt-svc headers
CREATE TEMPORARY FUNCTION getUpgradeHeader(payload STRING)
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
  client,
  firstHtml,
  JSON_EXTRACT_SCALAR(payload, "$._protocol") AS protocol,
  IF(url LIKE "https://%", "https", "http") AS http_or_https,
  getUpgradeHeader(payload) AS upgrade,
  COUNT(0) AS num_requests
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  firstHtml,
  protocol,
  http_or_https,
  upgrade
