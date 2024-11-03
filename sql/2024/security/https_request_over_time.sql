#standardSQL
# Section: Transport Security - ?
# Question: How many requests are made via HTTPS over time?
# Note: Currently all requests on the landing page; could be restricted to top-level requests only (is_main_document)
SELECT
  date,
  client,
  SUM(IF(STARTS_WITH(url, 'https'), 1, 0)) / COUNT(0) AS percent
FROM
  `httparchive.all.requests`
WHERE
  date >= '2022-06-01' AND
  is_root_page
# AND is_main_document
GROUP BY
  date,
  client
ORDER BY
  date DESC,
  client
