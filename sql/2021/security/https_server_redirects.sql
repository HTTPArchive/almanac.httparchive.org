#standardSQL
# Prevalence of server redirects from HTTP to HTTPS over Jan 2021 to Jul 2021
SELECT
  client,
  date,
  COUNT(DISTINCT url) AS total_urls_on_page,
  COUNT(DISTINCT(CASE WHEN url LIKE "http://%" THEN url END)) AS count_http_urls_on_page,
  COUNT(DISTINCT(CASE WHEN url LIKE "http://%" THEN url END)) / COUNT(DISTINCT url) AS pct_http_urls_on_page,
  COUNT(DISTINCT(CASE WHEN url LIKE "http://%" AND resp_location LIKE "https://%" AND status BETWEEN 300 AND 399 THEN url END)) AS count_http_urls_with_https_redirect_on_page,
  COUNT(DISTINCT(CASE WHEN url LIKE "http://%" AND resp_location LIKE "https://%" AND status BETWEEN 300 AND 399 THEN url END)) / COUNT(DISTINCT(CASE WHEN url LIKE "http://%" THEN url END)) AS pct_http_urls_with_https_redirect_on_page
FROM
  `httparchive.almanac.requests`
WHERE
  "2021-01-01" <= date AND date <= "2021-07-01"
GROUP BY
  client,
  date
ORDER BY
  client,
  date
