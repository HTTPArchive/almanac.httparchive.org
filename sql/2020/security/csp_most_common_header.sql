#standardSQL
# CSP on home pages: most commonly used header values
CREATE TEMPORARY FUNCTION getHeader(headers STRING, headername STRING) -- noqa: PRS
-- SQL Linter cannot handle DETERMINISTIC keyword so needs noqa ignore command on previous line
RETURNS STRING
DETERMINISTIC
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
  csp_header,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_csp_headers,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    getHeader(JSON_EXTRACT(payload, '$.response.headers'), 'Content-Security-Policy') AS csp_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = "2020-08-01" AND
    firstHtml
)
WHERE
  csp_header IS NOT NULL
GROUP BY
  client,
  csp_header
ORDER BY
  pct DESC
LIMIT 100
