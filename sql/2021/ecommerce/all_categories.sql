#standardSQL
# List of all categories for 2021_07_01
SELECT DISTINCT
  category
FROM
  `httparchive.technologies.2021_07_01_*`
ORDER BY
  category ASC
