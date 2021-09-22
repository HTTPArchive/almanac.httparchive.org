# standardSQL
# Number of HTTPS requests not using H2 or H3 returning upgrade HTTP header containing H2
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
  JSON_EXTRACT_SCALAR(payload, '$._protocol') AS http_version,
  COUNTIF(getUpgradeHeader(payload) LIKE "%h2%") AS num_requests,
  COUNT(0) AS total
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2020-08-01' AND
  url LIKE "https://%" AND
  LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) NOT LIKE "http/2" AND
  LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) NOT LIKE "%quic%" AND
  LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) NOT LIKE "h3%" AND
  LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) NOT LIKE "http/3%"
GROUP BY
  client,
  firstHtml,
  http_version
