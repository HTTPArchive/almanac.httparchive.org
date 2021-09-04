# standardSQL
# Count of preload HTTP Headers with nopush attribute set. Once off stat for last crawl
CREATE TEMPORARY FUNCTION getLinkHeaders(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS """
try {
  var $ = JSON.parse(payload);
  var headers = $.response.headers;
  return headers.filter(h => h.name.toLowerCase() == 'link').map(h => h.value);
} catch (e) {
  return [];
}
""";

SELECT
  client,
  COUNTIF(link_header LIKE '%nopush%') AS num_nopush,
  COUNT(0) AS total_preload,
  ROUND(COUNTIF(link_header LIKE '%nopush%') / COUNT(0), 4) AS pct_nopush
FROM (
  SELECT
    client,
    getLinkHeaders(payload) AS link_headers
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    firstHtml),
  UNNEST(link_headers) AS link_header
WHERE
  link_header LIKE '%preload%'
GROUP BY
  client
