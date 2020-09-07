#standardSQL
# 12_03: Most used apps
SELECT
  _TABLE_SUFFIX AS client,
  total_sites,

  category,
  app,
  COUNT(0) AS sites_with_app,
  ROUND(COUNT(0) * 100 / total_sites, 2) AS pct_sites_with_app
FROM
  `httparchive.almanac.technologies_desktop_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_sites
  FROM
    `httparchive.almanac.summary_pages_desktop_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
GROUP BY
  client,
  total_sites,
  category,
  app
ORDER BY
  pct_sites_with_app DESC
