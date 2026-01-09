#standardSQL
-- % of sites whose CSS variables include a gradient( ... ) per year, client, rank
-- Goal it use is as an indicator for vibe coded website like "delve into" is used for papers
SELECT
  EXTRACT(YEAR FROM date) AS year,
  client,
  rank,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT IF(
    REGEXP_CONTAINS(TO_JSON_STRING(custom_metrics.css_variables), r'(?i)gradient\('),
    page, NULL
  )) AS pages_with_gradient,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      REGEXP_CONTAINS(TO_JSON_STRING(custom_metrics.css_variables), r'(?i)gradient\('),
      page, NULL
    )),
    COUNT(DISTINCT page)
  ) AS pct_with_gradient
FROM
  `httparchive.crawl.pages`
WHERE
  is_root_page AND
  date IN (
    DATE '2019-07-01',
    DATE '2020-08-01',
    DATE '2021-07-01',
    DATE '2022-07-01', -- noqa: CV09
    DATE '2024-06-01',
    DATE '2025-07-01'
  )
GROUP BY
  year,
  client,
  rank
ORDER BY
  year,
  client,
  rank;
