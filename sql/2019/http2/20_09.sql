#standardSQL
# 20.09 - Count of non-HTTP/2 Sites Grouped By Server
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
  client,
  getServerHeader(payload) AS server_header,
  COUNT(0) AS num_pages,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2019-07-01' AND
  firstHtml AND
  JSON_EXTRACT_SCALAR(payload, "$._protocol") != "HTTP/2"
GROUP BY
  client,
  server_header
ORDER BY num_pages DESC
