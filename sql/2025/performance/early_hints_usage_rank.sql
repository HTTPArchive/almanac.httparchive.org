#standardSQL
# Early Hints (HTTP 103) usage by site rank
# Measures the percentage of sites using early hints at different popularity ranks

SELECT
  IF(ranking < 100000000, CAST(ranking AS STRING), 'all') AS ranking,
  r.client,
  COUNT(DISTINCT r.page) AS total_sites,
  COUNTIF(JSON_QUERY_ARRAY(r.payload._early_hint_headers) IS NOT NULL) AS sites_with_early_hints,
  COUNTIF(JSON_QUERY_ARRAY(r.payload._early_hint_headers) IS NOT NULL) / COUNT(DISTINCT r.page) AS pct_early_hints
FROM
  `httparchive.crawl.requests` r
JOIN
  `httparchive.crawl.pages` p
ON
  r.page = p.page AND
  r.client = p.client AND
  r.date = p.date,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS ranking
WHERE
  r.date = '2025-07-01' AND
  r.is_main_document AND
  r.is_root_page AND
  p.is_root_page AND
  p.rank <= ranking
GROUP BY
  ranking,
  r.client
ORDER BY
  ranking,
  r.client
