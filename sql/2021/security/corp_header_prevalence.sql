#standardSQL
# CORP usage: most commonly used header values
CREATE TEMPORARY FUNCTION getHeader(headers STRING, headername STRING)
RETURNS STRING DETERMINISTIC
LANGUAGE js AS '''
  const parsed_headers = JSON.parse(headers);
  const matching_headers = parsed_headers.filter(h => h.name.toLowerCase() == headername.toLowerCase());
  if (matching_headers.length > 0) {
    return matching_headers[0].value;
  }
  return null;
''';

SELECT
  client,
  corp_header,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_corp_headers,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(urlShort) AS host,
    getHeader(response_headers, 'Cross-Origin-Resource-Policy') AS corp_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = "2021-07-01"
)
WHERE
  corp_header IS NOT NULL
GROUP BY
  client,
  corp_header
ORDER BY
  pct DESC
LIMIT 100
