#standardSQL
# Section: Attack Preventions - Security header adoptions
# Question: How prevalent are security headers in a first-party context? (count by number of hosts)
# Note: Instead we could only look at top-level responses (is_main_document)?
SELECT
  date,
  client,
  headername,
  COUNT(DISTINCT host) AS total_hosts,
  COUNT(DISTINCT IF(LOWER(response_headers.name) = LOWER(headername), host, NULL)) AS count_with_header,
  COUNT(DISTINCT IF(LOWER(response_headers.name) = LOWER(headername), host, NULL)) / COUNT(DISTINCT host) AS pct_with_header
FROM (
  SELECT
    date,
    client,
    NET.HOST(url) AS host,
    response_headers
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    (date = '2022-06-09' OR date = '2023-06-01' OR DATE = '2024-06-01' OR date = '2025-07-01') AND
    NET.HOST(url) = NET.HOST(page)
),
  UNNEST([
    'Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy',
    'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To',
    'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection', 'Clear-Site-Data', 'Timing-Allow-Origin', 'Origin-Agent-Cluster'
  ]) AS headername
GROUP BY
  date,
  client,
  headername
ORDER BY
  date,
  client,
  headername
