# standardSQL
# Detailed alt-svc headers per request
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
  protocol,
  IF(url LIKE 'https://%', 'https', 'http') AS http_or_https,
  NORMALIZE_AND_CASEFOLD(extractHTTPHeader(response_headers, "alt-svc")) AS altsvc,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client,
  protocol,
  http_or_https,
  altsvc
QUALIFY -- Use QUALIFY rather than HAVING to allow total column to work
  num_requests >= 100
ORDER BY
  num_requests DESC
