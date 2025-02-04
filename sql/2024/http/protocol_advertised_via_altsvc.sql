#standardSQL
# Protocol advertised via alt-svc breakdown

CREATE TEMPORARY FUNCTION extractHTTPHeader(altsvcHeaderValue STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const result = [];
  const splittedAltSvcHeaderValue = altsvcHeaderValue.split(',');
  for (let altsvcToken of splittedAltSvcHeaderValue) {
    const protocolPortToken = altsvcToken.trim().split(';')[0];
    const protocolToken = protocolPortToken.split('=')[0];
    result.push(protocolToken);
  }
  return result;
} catch (e) {
  return [];
}
''';

WITH altsvcTable AS (
  SELECT
    client,
    url,
    extractHTTPHeader(resp_headers.value) AS protocol
  FROM
    `httparchive.all.requests`
  LEFT OUTER JOIN
    UNNEST(response_headers) AS resp_headers
  ON LOWER(resp_headers.name) = 'alt-svc'
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document
)

SELECT
  client,
  protocol,
  COUNT(0) AS protocol_count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_advertised,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_advertised
FROM
  (
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
  pct_advertised DESC
