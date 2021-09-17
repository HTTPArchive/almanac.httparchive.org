# standardSQL
# Number of HTTPS requests not using H2 or H3 returning upgrade HTTP header containing H2
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
  COUNTIF(extractHTTPHeader(response_headers, "upgrade") LIKE "%h2%") AS num_requests,
  COUNT(0) AS total
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01' AND
  url LIKE "https://%" AND
  LOWER(protocol) != "http/2" AND
  LOWER(protocol) NOT LIKE "%quic%" AND
  LOWER(protocol) NOT LIKE "h3%" AND
  LOWER(protocol) != "http/3"
GROUP BY
  client,
  firstHtml
