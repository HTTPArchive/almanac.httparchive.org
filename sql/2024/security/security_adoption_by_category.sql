#standardSQL
# Section: Drivers of security mechanism adoption - Website category
# Question: How prevalent are the various security headers on first-party resources? (per category)
# Note: Instead of the parent_category, we could ues full_category or subcategory (https://har.fyi/reference/functions/get_host_categories/)
# Note: Instead of using every "first-party" resource via url.host = page.host, we could only look at top-level documents (is_main_document) or responses of type document (top-level + iframes)?
SELECT
  client,
  headername,
  SPLIT(parent_category, '/')[1] AS category,
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
JOIN UNNEST(`httparchive.fn.GET_HOST_CATEGORIES`(url))
WHERE
  date = '2024-06-01' AND
  is_root_page AND
  is_main_document AND
  NET.HOST(url) = NET.HOST(page)

GROUP BY
  client,
  headername,
  category
ORDER BY
  pct_with_header DESC,
  client,
  headername,
  category
