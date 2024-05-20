#standardSQL
# Prevalence of security headers set in a first-party context; per rank grouping (1k, 10k, 100k, 1m, all)
CREATE TEMPORARY FUNCTION hasHeader(headers STRING, headername STRING)
RETURNS BOOL DETERMINISTIC
LANGUAGE js AS '''
  const parsed_headers = JSON.parse(headers);
  const matching_headers = parsed_headers.filter(h => h.name.toLowerCase() == headername.toLowerCase());
  return matching_headers.length > 0;
''';

SELECT
  client,
  headername,
  rank_grouping,
  COUNT(DISTINCT NET.HOST(urlShort)) AS total_hosts,
  COUNT(DISTINCT IF(hasHeader(response_headers, headername), NET.HOST(urlShort), NULL)) AS num_with_header,
  COUNT(DISTINCT IF(hasHeader(response_headers, headername), NET.HOST(urlShort), NULL)) / COUNT(DISTINCT NET.HOST(urlShort)) AS pct_with_header
FROM
  `httparchive.almanac.requests`,
  UNNEST([
    'Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy',
    'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To',
    'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection'
  ]) AS headername,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  date = '2021-07-01' AND
  rank <= rank_grouping AND
  NET.HOST(urlShort) = NET.HOST(page)
GROUP BY
  client,
  headername,
  rank_grouping
ORDER BY
  client,
  headername,
  rank_grouping
