#standardSQL
# Prevalence of server information headers set in a first-party context; count by number of hosts.
-- SQL Linter cannot handle DETERMINISTIC keyword so needs noqa ignore command on previous line
CREATE TEMPORARY FUNCTION hasHeader(headers STRING, headername STRING)  -- noqa: PRS
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
  COUNT(DISTINCT IF(hasHeader(headers, headername), host, NULL)) AS count_with_header,
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
    (date = "2020-08-01" OR date = "2021-08-01") AND
    NET.HOST(urlShort) = NET.HOST(page)
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
