#standardSQL
# 06_04: counts font-display value usage
SELECT
  score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM (
  SELECT
    JSON_EXTRACT(report, '$.audits.font-display.score') AS score
  FROM
    `httparchive.lighthouse.2019_07_01_*`
)
WHERE
  score IS NOT NULL
GROUP BY
  score
ORDER BY
  freq / total DESC
