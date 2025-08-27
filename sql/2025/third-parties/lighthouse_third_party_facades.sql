SELECT
  client,
  fail,
  total,
  pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNTIF(SAFE_CAST(JSON_VALUE(report, '$.audits.third-party-facades.score') AS FLOAT64) < 0.9) AS fail,
    SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
    COUNTIF(SAFE_CAST(JSON_VALUE(report, '$.audits.third-party-facades.score') AS FLOAT64) < 0.9) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
  FROM
    `httparchive.lighthouse.2025_07_01_*`
  GROUP BY
    client
)
WHERE
  total > 100
ORDER BY
  client
