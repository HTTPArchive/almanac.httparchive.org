#standardSQL
# Prevalence of security headers set in a first-party context; count by number of hosts.
CREATE TEMPORARY FUNCTION hasHeader(headers STRING, headername STRING)
  RETURNS BOOL DETERMINISTIC
  LANGUAGE js AS '''
  const parsed_headers = JSON.parse(headers);
  const matching_headers = parsed_headers.filter(h => h.name.toLowerCase() == headername.toLowerCase());
  return matching_headers.length > 0;
''';

SELECT
  date,
  client,
  headername,
  COUNT(DISTINCT host) AS total_hosts,
  COUNT(DISTINCT IF(hasHeader(headers, headername), host, NULL)) AS num_with_header,
  COUNT(DISTINCT IF(hasHeader(headers, headername), host, NULL)) / COUNT(DISTINCT host) AS pct_with_header
FROM (
  SELECT
    date,
    client,
    NET.HOST(urlShort) AS host,
    JSON_EXTRACT(payload, '$.response.headers') AS headers
  FROM
    `httparchive.almanac.requests`
  WHERE
    (date = "2020-08-01" OR date = "2019-07-01") AND
    NET.HOST(urlShort) = NET.HOST(page)
),
UNNEST(['Content-Security-Policy', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy', 'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To', 'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection']) AS headername
GROUP BY
  date,
  client,
  headername
ORDER BY
  date,
  client,
  headername
