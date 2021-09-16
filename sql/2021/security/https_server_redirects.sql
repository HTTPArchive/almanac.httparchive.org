#standardSQL
# Prevalence of server redirects from HTTP to HTTPS over Jan 2021 to Aug 2021
SELECT
  client,
  date,
  COUNT(DISTINCT url) AS total_http_urls_on_page,
  COUNT(DISTINCT(CASE WHEN resp_location LIKE "https://%" THEN url END)) AS count_https_redirect,
  COUNT(DISTINCT(CASE WHEN resp_location LIKE "https://%" THEN url END)) / COUNT(DISTINCT url) AS pct_https_redirect
FROM
  `httparchive.almanac.requests`
WHERE
  "2021-01-01" <= date AND date <= "2021-08-01" AND
  status BETWEEN 300 AND 399 AND
  url LIKE "http://%"
GROUP BY
  client,
  date
ORDER BY
  client,
  date
