#standardSQL
# Protocol advertised via alt-svc breakdown
CREATE TEMPORARY FUNCTION extractHTTPHeader(HTTPheaders STRING, header STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS """
try {
  var headers = JSON.parse(HTTPheaders);

  // Filter by header name (which is case insensitive)
  // If multiple headers it's the same as comma separated
  const result = [];
  const allAltSvcHeaderValues = headers.filter(h => h.name.toLowerCase() == header.toLowerCase()).map(h => h.value);
  for (let altsvcHeaderValue of allAltSvcHeaderValues) {
    const splittedAltSvcHeaderValue = altsvcHeaderValue.split(",");
    for (let altsvcToken of splittedAltSvcHeaderValue) {
      const protocolPortToken = altsvcToken.trim().split(";")[0];
      const protocolToken = protocolPortToken.split("=")[0];
      result.push(protocolToken);
    }
  }
  return result;
} catch (e) {
  return [];
}
""";

WITH altsvcTable AS (
  SELECT
    client,
    url,
    extractHTTPHeader(response_headers, 'alt-svc') AS protocol
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    firstHtml
)

SELECT
  client,
  protocol,
  COUNT(0) AS protocol_count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_advertised,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_advertised
FROM (
  SELECT
    client,
    url,
    flattened_protocol AS protocol
  FROM
    altsvcTable, altsvcTable.protocol AS flattened_protocol
)
GROUP BY
  client,
  protocol
ORDER BY
  client ASC,
  total_advertised DESC
