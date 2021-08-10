#standardSQL
# 20.04 - Number of HTTP (not HTTPS) sites which return upgrade HTTP header containing h2.
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
  COUNT(0) AS num_requests
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2019-07-01' AND
  url LIKE "http://%" AND
  getUpgradeHeader(payload) LIKE "%h2%"
GROUP BY
  client,
  firstHtml
