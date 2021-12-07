#standardSQL
# CSP on home pages: most prevalent allowed hosts
CREATE TEMPORARY FUNCTION getHeader(headers STRING, headername STRING)
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
  csp_allowed_host,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total_pages,
  COUNT(DISTINCT page) AS freq,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    getHeader(JSON_EXTRACT(payload, '$.response.headers'), 'Content-Security-Policy') AS csp_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = "2020-08-01" AND
    firstHtml
),
UNNEST(REGEXP_EXTRACT_ALL(csp_header, r'(?i)(https*://[^\s;]+)[\s;]')) AS csp_allowed_host
WHERE
  csp_header IS NOT NULL
GROUP BY
  client,
  csp_allowed_host
ORDER BY
  pct DESC
LIMIT 100
