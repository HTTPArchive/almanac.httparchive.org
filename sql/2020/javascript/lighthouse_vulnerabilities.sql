#standardSQL
# Pages with vulnerable libraries
SELECT
  score,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY 0) AS pct
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, "$.audits['no-vulnerable-libraries'].score") AS score
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`)
WHERE
  score IS NOT NULL
GROUP BY
  score
ORDER BY
  score
