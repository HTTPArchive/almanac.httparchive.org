SELECT
  app,
  count(0) AS urls
FROM `httparchive.technologies.2022_06_01_mobile`
WHERE category = 'Static site generator'
GROUP BY app
ORDER BY urls DESC
