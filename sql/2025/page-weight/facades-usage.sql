SELECT
  client,
  is_root_page,
  COUNTIF(JSON_VALUE(lighthouse.audits['third-party-facades'].score) IS NOT NULL) AS pages_with_facades_available,
  COUNTIF(JSON_VALUE(lighthouse.audits['third-party-facades'].scoreDisplayMode) = 'notApplicable') AS not_applicable_count,
  SUM(CAST(JSON_VALUE(lighthouse.audits['third-party-facades'].metricSavings.TBT) AS FLOAT64)) AS total_blocking_time_savings_ms,
  COUNT(0) AS total_pages,
  COUNTIF(JSON_VALUE(lighthouse.audits['third-party-facades'].score) IS NOT NULL) / (COUNT(0) - COUNTIF(JSON_VALUE(lighthouse.audits['third-party-facades'].scoreDisplayMode) = 'notApplicable')) AS pct_pages_with_opportunities
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page
