# standardSQL
# Number of favicons returning a 404

SELECT
  client,
  COUNTIF(url LIKE '%favicon.ico' AND status = 404) AS num_favicon_404s,
  COUNTIF(status = 404) AS All404s,
  COUNT(0) AS total_requests,
  COUNTIF(url LIKE '%favicon.ico' AND status = 404) / COUNTIF(status = 404) AS favicon_404s_pct,
  COUNTIF(url LIKE '%favicon.ico' AND status = 404) / COUNT(0) AS favicon_404s_pct_all_requests
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client
