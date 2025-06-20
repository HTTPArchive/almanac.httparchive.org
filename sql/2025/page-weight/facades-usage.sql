SELECT
  client,
  is_root_page,
  COUNTIF(JSON_VALUE(lighthouse, '$.audits.third-party-facades.score') IS NULL) AS null_count,
  COUNTIF(SAFE_CAST(JSON_VALUE(lighthouse, '$.audits.third-party-facades.score') AS FLOAT64) >= 0.9) AS pass_count,
  COUNTIF(SAFE_CAST(JSON_VALUE(lighthouse, '$.audits.third-party-facades.score') AS FLOAT64) < 0.9) AS fail_count,
  COUNT(0) AS total,
  COUNTIF(SAFE_CAST(JSON_VALUE(lighthouse, '$.audits.third-party-facades.score') AS FLOAT64) >= 0.9) / COUNT(0) AS pct_pass,
  COUNTIF(SAFE_CAST(JSON_VALUE(lighthouse, '$.audits.third-party-facades.score') AS FLOAT64) < 0.9) / COUNT(0) AS pct_fail
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page,
  null_count,
  pass_count,
  fail_count
