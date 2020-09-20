#standardSQL
# 12_03: Most used apps
SELECT
  total_sites,

  category,
  app,
  COUNT(0) AS sites_with_app,
  ROUND(COUNT(0) * 100 / total_sites, 2) AS pct_sites_with_app
FROM
  `httparchive.technologies.2020_08_01_mobile`
CROSS JOIN (
  SELECT
    COUNT(0) AS total_sites
  FROM
    `httparchive.summary_pages.2020_08_01_mobile`
)
GROUP BY
  total_sites,
  category,
  app
ORDER BY
  pct_sites_with_app DESC
