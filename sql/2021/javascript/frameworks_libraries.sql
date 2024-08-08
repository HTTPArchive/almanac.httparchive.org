#standardSQL
# Top JS frameworks and libraries
SELECT
  _TABLE_SUFFIX AS client,
  category,
  app,
  COUNT(DISTINCT url) AS pages,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2021_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  category IN ('JavaScript frameworks', 'JavaScript libraries')
GROUP BY
  client,
  category,
  app,
  total
ORDER BY
  pct DESC
