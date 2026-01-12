#standardSQL
# Section: Transport Security - Unused?
# Question: How many HTTP requests exist on pages and how many of them server-side redirect to HTTPS
# Note: Does not distinguish between whether the main Page URL is HTTP or HTTPS
SELECT
  client,
  date,
  COUNT(DISTINCT url) AS total_urls_on_page,
  COUNT(DISTINCT(CASE WHEN url LIKE 'http://%' THEN url END)) AS count_http_urls_on_page,
  COUNT(DISTINCT(CASE WHEN url LIKE 'http://%' THEN url END)) / COUNT(DISTINCT url) AS pct_http_urls_on_page,
  COUNT(DISTINCT(CASE WHEN url LIKE 'http://%' AND (SELECT value FROM UNNEST(response_headers) WHERE LOWER(name) = 'location' LIMIT 1) LIKE 'https://%' AND INT64(summary.status) BETWEEN 300 AND 399 THEN url END)) AS count_http_urls_with_https_redirect_on_page,
  COUNT(DISTINCT(CASE WHEN url LIKE 'http://%' AND (SELECT value FROM UNNEST(response_headers) WHERE LOWER(name) = 'location' LIMIT 1) LIKE 'https://%' AND INT64(summary.status) BETWEEN 300 AND 399 THEN url END)) / COUNT(DISTINCT(CASE WHEN url LIKE 'http://%' THEN url END)) AS pct_http_urls_with_https_redirect_on_page
FROM
  `httparchive.crawl.requests`
  UNNEST(response_headers) AS response_headers
WHERE
  date = '2025-07-01' AND
  is_root_page
GROUP BY
  client,
  date
ORDER BY
  client,
  date
