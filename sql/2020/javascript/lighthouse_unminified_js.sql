#standardSQL
# Pages with unminified JS
SELECT
  score,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER () AS total,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, "$.audits['unminified-javascript'].score") AS score
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`)
WHERE
  score IS NOT NULL
GROUP BY
  score
ORDER BY
  score
