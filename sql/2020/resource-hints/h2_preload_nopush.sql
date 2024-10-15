#standardSQL
#19_15: Count of preload HTTP Headers with nopush attribute set.
CREATE TEMPORARY FUNCTION getLinkHeaders(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS """
try {
  var $ = JSON.parse(payload);
  var headers = $.response.headers;
  var preload=[];

  for (i in headers) {
    if (headers[i].name.toLowerCase() === 'link')
      preload.push(headers[i].value);
    }
  return preload;
} catch (e) {
  return [];
}
""";

SELECT
  client,
  firstHtml,
  COUNT(0) AS num_requests,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    firstHtml,
    getLinkHeaders(payload) AS link_headers
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01'
),
  UNNEST(link_headers) AS link_header
WHERE
  link_header LIKE '%preload%' AND
  link_header LIKE '%nopush%'
GROUP BY
  client,
  firstHtml
