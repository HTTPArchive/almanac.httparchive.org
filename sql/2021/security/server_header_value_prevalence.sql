#standardSQL
# Prevalence of server information headers set in a first-party context; count by number of hosts.
-- SQL Linter cannot handle DETERMINISTIC keyword so needs noqa ignore command on previous line
CREATE TEMPORARY FUNCTION getServerHeaderValue(headers STRING)  -- noqa: PRS
  RETURNS STRING DETERMINISTIC
  LANGUAGE js AS '''
  const parsed_headers = JSON.parse(headers);
  const matching_headers = parsed_headers.filter(h => h.name.toLowerCase() == "server");
  return matching_headers.length == 0 ? null : parsed_headers.filter(h => h.name.toLowerCase() == "server")[0]["value"];
''';

SELECT
  date,
  client,
  header_value,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_server_headers,
  COUNT(DISTINCT host) AS header_value_count,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS header_value_pct
FROM (
  SELECT
    date,
    client,
    NET.HOST(urlShort) AS host,
    getServerHeaderValue(JSON_EXTRACT(payload, '$.response.headers')) AS header_value
  FROM
    `httparchive.almanac.requests`
  WHERE
    (date = "2020-08-01" OR date = "2021-08-01") AND
    NET.HOST(urlShort) = NET.HOST(page)
)
WHERE
  header_value IS NOT NULL
GROUP BY
  date,
  client,
  header_value
ORDER BY
  date,
  header_value_count DESC,
  client
LIMIT 40
