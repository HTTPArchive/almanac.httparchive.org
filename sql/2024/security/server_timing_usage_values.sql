#standardSQL
# Section: Security misconfigurations and oversights - (Missing) suppression of 'Server-Timing' header
# Question: Which are the most common server-timing headers and how often are they used in total?
# Note: Probably better to split some of the things up to make the interpretation of the results easier
# Note: Server-Timing sent to same-origin/top-level requests is not an issue, maybe only look at non first-party requests?
WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01'
    AND is_root_page
  GROUP BY
    client
)

SELECT
  client,
  server_timing_header,
  total as total_responses,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS total_server_timing_headers,
  SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) / total AS pct_server_timing,
  COUNT(DISTINCT host) AS freq,
  COUNT(host) AS freq_non_unique,
  COUNT(DISTINCT host) / SUM(COUNT(DISTINCT host)) OVER (PARTITION BY client) AS pct_value,
  REGEXP_EXTRACT(server_timing_header, r'dur=(\d+\.?\d*)') as dur_value
FROM (
  SELECT
    client,
    total,
    NET.HOST(url) AS host,
    response_headers.value AS server_timing_header
  FROM
    `httparchive.all.requests`,
    UNNEST (response_headers) AS response_headers
  JOIN totals USING (client)
  WHERE
    date = '2024-06-01'
    AND is_root_page
    AND LOWER(response_headers.name) = 'server-timing' )
GROUP BY
  client,
  total,
  server_timing_header
ORDER BY
  pct_value DESC
LIMIT
  100