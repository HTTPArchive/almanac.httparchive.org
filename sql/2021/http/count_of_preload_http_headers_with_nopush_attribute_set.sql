# standardSQL
# Count of preload HTTP Headers with nopush attribute set. Once off stat for last crawl
CREATE TEMPORARY FUNCTION extractHTTPHeaders(HTTPheaders STRING, header STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS """
try {
  var headers = JSON.parse(HTTPheaders);

  // Filter by header name (which is case insensitive) and return values
  return headers.filter(h => h.name.toLowerCase() == header.toLowerCase()).map(h => h.value);

} catch (e) {
  return [];
}
""";

SELECT
  client,
  COUNTIF(link_header LIKE '%nopush%') AS num_nopush,
  COUNT(0) AS total_preload_http_headers,
  COUNTIF(link_header LIKE '%nopush%') / COUNT(0) AS pct_nopush,
  COUNTIF(link_header NOT LIKE '%nopush%') / COUNT(0) AS pct_push
FROM (
  SELECT
    client,
    extractHTTPHeaders(response_headers, 'link') AS link_headers
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml
),
  UNNEST(link_headers) AS link_header
WHERE
  link_header LIKE '%preload%'
GROUP BY
  client
ORDER BY
  client
