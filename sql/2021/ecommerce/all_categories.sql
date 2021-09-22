#standardSQL
# List of all categories
SELECT DISTINCT
  app
FROM
  `httparchive.technologies.2021_07_01_*`
ORDER BY
  category ASC
