# standardSQL
# Number of HTTPS requests using HTTP/2 which return upgrade HTTP header containing h2
CREATE TEMPORARY FUNCTION extractHTTPHeader(HTTPheaders STRING, header STRING)
RETURNS STRING LANGUAGE js AS """
try {
  var headers = JSON.parse(HTTPheaders);

  // Filter by header name (which is case insensitive)
  // If multiple headers it's the same as comma separated
  return headers.filter(h => h.name.toLowerCase() == header.toLowerCase()).map(h => h.value).join(",");

} catch (e) {
  return "";
}
 """;

SELECT
  client,
  firstHtml,
  protocol AS http_version,
  COUNTIF(extractHTTPHeader(response_headers, "upgrade") LIKE "%h2%") AS num_requests,
  COUNT(0) AS total,
  COUNTIF(extractHTTPHeader(response_headers, "upgrade") LIKE "%h2%") / COUNT(0) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01' AND
  url LIKE "https://%" AND
  LOWER(protocol) = "http/2"
GROUP BY
  client,
  firstHtml,
  http_version
ORDER BY
  pct DESC,
  client,
  firstHtml,
  http_version
