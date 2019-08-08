#standardSQL
# 01_10: Top JS frameworks
SELECT
  app,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  (SELECT COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*`),
  `httparchive.technologies.2019_07_01_*`
WHERE
  category = 'JavaScript Frameworks'
GROUP BY
  app,
  total
ORDER BY
  freq DESC