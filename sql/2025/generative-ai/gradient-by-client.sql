#standardSQL
-- Gradient adoption in CSS variables over time (by year + client, no rank)
-- Detects any "gradient(" inside custom_metrics.css_variables
SELECT
  EXTRACT(YEAR FROM date) AS year,
  client,
  COUNT(DISTINCT page) AS total_sites,
  COUNT(DISTINCT IF(
    REGEXP_CONTAINS(TO_JSON_STRING(custom_metrics.css_variables), r'(?i)gradient\('),
    page, NULL
  )) AS sites_using_gradient,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      REGEXP_CONTAINS(TO_JSON_STRING(custom_metrics.css_variables), r'(?i)gradient\('),
      page, NULL
    )),
    COUNT(DISTINCT page)
  ) AS pct_sites_using_gradient
FROM `httparchive.crawl.pages`
WHERE
  is_root_page
  AND date IN (
    DATE '2019-07-01',
    DATE '2020-08-01',
    DATE '2021-07-01',
    DATE '2022-07-01', -- CSS parsed-data exception (July)
    DATE '2024-06-01',
    DATE '2025-07-01'
  )
GROUP BY year, client
ORDER BY year, client;
