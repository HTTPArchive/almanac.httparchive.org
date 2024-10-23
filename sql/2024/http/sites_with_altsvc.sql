#standardSQL
# Fraction of sites with alt-svc header

SELECT
  client,
  COUNTIF(resp_headers.value IS NOT NULL) AS sites_with_altsvc,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNTIF(resp_headers.value IS NOT NULL) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_sites_with_altsvc
FROM
  `httparchive.all.requests`
LEFT OUTER JOIN
  UNNEST(response_headers) AS resp_headers ON LOWER(resp_headers.name) = 'alt-svc'
WHERE
  date = '2024-06-01' AND
  is_root_page AND
  is_main_document
GROUP BY
  client
ORDER BY
  pct_sites_with_altsvc DESC
