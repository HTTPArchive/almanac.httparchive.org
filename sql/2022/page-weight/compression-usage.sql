SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(JSON_VALUE(report, '$.audits.text-compression.score') IS NULL) AS null_count,
  COUNTIF(SAFE_CAST(JSON_VALUE(report, '$.audits.text-compression.score') AS FLOAT64) >= 0.9) AS pass_count,
  COUNTIF(SAFE_CAST(JSON_VALUE(report, '$.audits.text-compression.score') AS FLOAT64) < 0.9) AS fail_count
FROM
  `httparchive.lighthouse.2022_06_01_*`
GROUP BY
  client
ORDER BY
    client,
    null_count,
    pass_count,
    fail_count