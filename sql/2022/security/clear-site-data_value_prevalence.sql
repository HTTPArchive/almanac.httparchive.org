#standardSQL
# Prevalence of Clear-Site-Data header values
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
  csd_header,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_csd_headers,
  COUNT(DISTINCT host) AS freq,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    NET.HOST(urlShort) AS host,
    getHeader(response_headers, 'Clear-Site-Data') AS csd_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01'
)
WHERE
  csd_header IS NOT NULL
GROUP BY
  client,
  csd_header
ORDER BY
  pct DESC
LIMIT 100
