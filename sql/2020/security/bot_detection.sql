#standardSQL
SELECT
  _TABLE_SUFFIX AS client,
  app,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  `httparchive.technologies.2020_08_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
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
  freq / total DESC
