#standardSQL
# 01_08: Top JS libraries
SELECT
  app,
  COUNT(DISTINCT url) AS freq,
  total,
  ROUND(COUNT(DISTINCT url) * 100 / total, 2) AS pct
FROM
  (SELECT COUNT(DISTINCT url) AS total FROM `httparchive.summary_pages.2019_07_01_*`),
  `httparchive.technologies.2019_07_01_*`
WHERE
  category = 'JavaScript Libraries'
GROUP BY
  app,
  total
ORDER BY
  freq DESC