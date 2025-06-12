#standardSQL
# Pages with vulnerable libraries
SELECT
  client,
  score,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(report, "$.audits['no-vulnerable-libraries'].score") AS score
  FROM
    `httparchive.lighthouse.2022_06_01_*`
)
WHERE
  score IS NOT NULL
GROUP BY
  client,
  score
ORDER BY
  client,
  score
