#standardSQL
# Early Hints (HTTP 103) adoption trend over time
# Shows usage by client (mobile, desktop) across years

SELECT
  r.client AS client,
  r.date AS date,
  COUNTIF(
    JSON_QUERY_ARRAY(r.payload._early_hint_headers) IS NOT NULL AND
    ARRAY_LENGTH(JSON_QUERY_ARRAY(r.payload._early_hint_headers)) > 0
  ) AS sites,
  COUNT(0) AS total,
  COUNTIF(
    JSON_QUERY_ARRAY(r.payload._early_hint_headers) IS NOT NULL AND
    ARRAY_LENGTH(JSON_QUERY_ARRAY(r.payload._early_hint_headers)) > 0
  ) / COUNT(0) AS pct
FROM
  `httparchive.crawl.requests` r
JOIN
  `httparchive.crawl.pages` p
ON
  r.page = p.page AND
  r.client = p.client AND
  r.date = p.date
WHERE
  r.date IN ('2023-07-01', '2024-07-01', '2025-07-01') AND -- noqa: CV09
  r.is_main_document AND
  r.is_root_page AND
  p.is_root_page
GROUP BY
  r.client,
  r.date
ORDER BY
  r.client,
  r.date
