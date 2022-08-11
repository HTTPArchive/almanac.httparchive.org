SELECT
  app,
  count(0)
FROM `httparchive.technologies.2022_06_01_mobile`
WHERE category = 'JavaScript frameworks'
GROUP BY app
ORDER BY count(0) DESC
