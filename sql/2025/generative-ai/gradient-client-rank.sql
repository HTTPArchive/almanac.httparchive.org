#standardSQL
-- Adoption of CSS gradients in custom_metrics.css_variables
-- Grouped by: year, client, rank bucket

WITH ranks AS (
  SELECT 1000 AS rank_grouping UNION ALL
  SELECT 10000 UNION ALL
  SELECT 100000 UNION ALL
  SELECT 1000000 UNION ALL
  SELECT 10000000 UNION ALL
  SELECT 100000000
)

SELECT
  EXTRACT(YEAR FROM date) AS year,
  client,
  r.rank_grouping,
  COUNT(DISTINCT page) AS total_sites,
  COUNT(DISTINCT IF(
    REGEXP_CONTAINS(
      TO_JSON_STRING(custom_metrics.css_variables),
      r'(?i)gradient\('
    ),
    page,
    NULL
  )) AS sites_using_gradient,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      REGEXP_CONTAINS(
        TO_JSON_STRING(custom_metrics.css_variables),
        r'(?i)gradient\('
      ),
      page,
      NULL
    )),
    COUNT(DISTINCT page)
  ) AS pct_sites_using_gradient
FROM `httparchive.crawl.pages`
CROSS JOIN ranks r
WHERE
  is_root_page
  AND rank <= r.rank_grouping
  AND date IN (
    DATE '2019-07-01',
    DATE '2020-08-01',
    DATE '2021-07-01',
    DATE '2022-07-01', -- CSS metrics exception
    DATE '2024-06-01',
    DATE '2025-07-01'
  )
GROUP BY year, client, r.rank_grouping
ORDER BY year, client, r.rank_grouping;
