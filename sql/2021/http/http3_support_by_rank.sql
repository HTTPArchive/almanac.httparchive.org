# standardSQL
# Percentage of sites by rank, that either use or support HTTP/3 on home page
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
  rank_grouping,
  CASE
    WHEN rank_grouping = 10000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM (
  SELECT
    client,
    page,
    rank
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHTML AND (
      LOWER(protocol) IN ('http/3', 'quic', 'h3-29', 'h3-q050') OR
      extractHTTPHeader(response_headers, 'alt-svc') LIKE '%h3%'
    )
),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
JOIN (
  SELECT
    client,
    rank_grouping,
    COUNT(0) AS total
  FROM
    `httparchive.almanac.requests`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    date = '2021-07-01' AND
    rank <= rank_grouping AND
    firstHTML
  GROUP BY
    client,
    rank_grouping
)
USING (client, rank_grouping)
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  total,
  rank_grouping
ORDER BY
  client,
  rank_grouping
