#standardSQL
# Prevalence of server information headers; count by number of hosts.
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
  COUNT(DISTINCT IF(hasHeader(response_headers, headername), host, NULL)) AS count_with_header,
  COUNT(DISTINCT IF(hasHeader(response_headers, headername), host, NULL)) / COUNT(DISTINCT host) AS pct_with_header
FROM (
  SELECT
    date,
    client,
    NET.HOST(urlShort) AS host,
    response_headers
  FROM
    `httparchive.almanac.requests`
  WHERE (date = '2020-08-01' OR date = '2021-07-01')
),
  UNNEST(['Server', 'X-Server', 'X-Backend-Server', 'X-Powered-By', 'X-Aspnet-Version']) AS headername
GROUP BY
  date,
  client,
  headername
ORDER BY
  date,
  client,
  count_with_header DESC
