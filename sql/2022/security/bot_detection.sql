#standardSQL
SELECT
  _TABLE_SUFFIX AS client,
  app,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.technologies.2022_06_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  category = 'Security'
GROUP BY
  client,
  total,
  app
ORDER BY
  pct DESC
