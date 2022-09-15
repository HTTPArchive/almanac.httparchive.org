SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(JSON_VALUE(report, '$.audits.unminified-javascript.score') IS NULL) AS null_count,
  COUNTIF(SAFE_CAST(JSON_VALUE(report, '$.audits.unminified-javascript.score') AS FLOAT64) >= 0.9) AS pass_count,
  COUNTIF(SAFE_CAST(JSON_VALUE(report, '$.audits.unminified-javascript.score') AS FLOAT64) < 0.9) AS fail_count,
  COUNT(0) AS total,
  COUNTIF(SAFE_CAST(JSON_VALUE(report, '$.audits.unminified-javascript.score') AS FLOAT64) >= 0.9) / COUNT(0) AS pct_pass,
  COUNTIF(SAFE_CAST(JSON_VALUE(report, '$.audits.unminified-javascript.score') AS FLOAT64) < 0.9) / COUNT(0) AS pct_fail
FROM
  `httparchive.lighthouse.2022_06_01_*`
GROUP BY
  client
ORDER BY
  client,
  null_count,
  pass_count,
  fail_count
