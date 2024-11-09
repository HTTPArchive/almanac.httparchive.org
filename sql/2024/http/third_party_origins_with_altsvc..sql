#standardSQL
# Fraction of sites with alt-svc header by request origin

SELECT
  client,
  NET.HOST(url) AS origin,
  COUNT(DISTINCT page) AS sites_using_origin,
  COUNT(DISTINCT IF(resp_headers.value IS NOT NULL, page, NULL)) AS sites_with_altsvc,
  COUNT(DISTINCT IF(resp_headers.value IS NOT NULL, page, NULL)) / COUNT(DISTINCT page) AS pct_sites_with_altsvc
FROM
  `httparchive.all.requests`
LEFT OUTER JOIN
  UNNEST(response_headers) AS resp_headers ON LOWER(resp_headers.name) = 'alt-svc'
WHERE
  date = '2024-06-01' AND
  is_root_page
GROUP BY
  client,
  NET.HOST(url)
ORDER BY
  sites_using_origin DESC
LIMIT 10000
