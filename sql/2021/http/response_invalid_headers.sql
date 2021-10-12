# standardSQL
# List of invalid header names containing either a space or non-ASCII characters
CREATE TEMPORARY FUNCTION extractHTTPHeaders(HTTPheaders STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS """
try {
  var headers = JSON.parse(HTTPheaders);

  // Filter by header name (which is case insensitive)
  // If multiple headers it's the same as comma separated
  return headers.map(h => h.name.toLowerCase());

} catch (e) {
  return "";
}
 """;

SELECT
  client,
  header,
  COUNT(0) AS num_requests,
  total,
  COUNT(0) / total AS pct,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT url LIMIT 5), ' ') AS sample_urls
FROM
  `httparchive.almanac.requests`,
  UNNEST(extractHTTPHeaders(response_headers)) AS header
JOIN
  (
    SELECT
      client,
      COUNT(0) AS total
    FROM
      `httparchive.almanac.requests`
    GROUP BY
      client
  )
USING (client)
WHERE
  date = '2021-07-01' AND
  (
    (
      header LIKE '% %' AND
      header NOT LIKE 'http/1.1 %' AND
      header NOT LIKE 'http/1.0 %'
    ) OR (
      REGEXP_REPLACE(header, r'([^\p{ASCII}]+)', '') != header
    )
  )
GROUP BY
  client,
  header,
  total
ORDER BY
  pct DESC,
  client
LIMIT 1000
