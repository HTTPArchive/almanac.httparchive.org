#standardSQL
# Section: Drivers of security mechanism adoption - Website popularity
# Question: How prevalent are the various security headers on first-party resources? (per rank grouping 1K, 5K, 10K, 100K, 500K, 1M, ...)
# Note: Buckets do not include prior ranks
# Note: Instead of using every "first-party" resource via url.host = page.host, we could only look at top-level documents (is_main_document) or responses of type document (top-level + iframes)?
SELECT
  client,
  headername,
  rank AS rank_grouping,
  COUNT(DISTINCT NET.HOST(url)) AS total_hosts,
  COUNT(DISTINCT IF(LOWER(rh.name) = LOWER(headername), NET.HOST(url), NULL)) AS num_with_header,
  COUNT(DISTINCT IF(LOWER(rh.name) = LOWER(headername), NET.HOST(url), NULL)) / COUNT(DISTINCT NET.HOST(url)) AS pct_with_header
FROM
  `httparchive.all.requests`,
  UNNEST([
    'Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy',
    'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To',
    'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection', 'Clear-Site-Data', 'Timing-Allow-Origin', 'Origin-Agent-Cluster'
  ]) AS headername,
  UNNEST(response_headers) AS rh
JOIN `httparchive.all.pages` USING (client, page, date, is_root_page)
WHERE
  date = '2024-06-01' AND
  is_root_page AND
  NET.HOST(url) = NET.HOST(page)

GROUP BY
  client,
  headername,
  rank_grouping
ORDER BY
  client,
  headername,
  rank_grouping
