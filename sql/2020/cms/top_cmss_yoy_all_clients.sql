#standardSQL
# Top CMS platforms, compared to 2019.
# Note that this query combines desktop and mobile datasets.
SELECT
  2020 AS year,
  app AS cms,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2020_08_01_*`
CROSS JOIN (
  SELECT
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
)
WHERE
  category = 'CMS'
GROUP BY
  total,
  cms
UNION ALL
SELECT
  2019 AS year,
  app AS cms,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2019_07_01_*`
CROSS JOIN (
  SELECT
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.summary_pages.2019_07_01_*`
)
WHERE
  category = 'CMS'
GROUP BY
  total,
  cms
ORDER BY
  pct DESC,
  year DESC
