#standardSQL
# Most used technologies - mobile only
SELECT
  total_pages,

  category,
  app,
  COUNT(0) AS pages_with_app,
  COUNT(0) / total_pages AS pct_pages_with_app
FROM
  `httparchive.technologies.2021_07_01_mobile`
CROSS JOIN (
  SELECT
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2021_07_01_mobile`
)
GROUP BY
  total_pages,
  category,
  app
ORDER BY
  pct_pages_with_app DESC
