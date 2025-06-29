SELECT
  date,
  client,
  COUNTIF(SAFE_CAST(JSON_VALUE(lighthouse.audits.`render-blocking-resources`.score) AS FLOAT64) >= 0.9) AS is_passing,
  COUNT(0) AS total,
  COUNTIF(SAFE_CAST(JSON_VALUE(lighthouse.audits.`render-blocking-resources`.score) AS FLOAT64) >= 0.9) / COUNT(0) AS pct_passing
FROM
  `httparchive.crawl.pages`
WHERE
  date IN ('2023-06-01', '2024-06-01', '2025-06-01') AND
  is_root_page
GROUP BY
  date,
  client
