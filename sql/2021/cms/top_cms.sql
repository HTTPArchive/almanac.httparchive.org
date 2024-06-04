#standardSQL
# Top CMS platforms, compared to 2020
SELECT
  _TABLE_SUFFIX AS client,
  2021 AS year,
  app AS cms,
  COUNT(DISTINCT url) AS freq,
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
  category = 'CMS'
GROUP BY
  client,
  total,
  cms
UNION ALL
SELECT
  _TABLE_SUFFIX AS client,
  2020 AS year,
  app AS cms,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
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
  category = 'CMS'
GROUP BY
  client,
  total,
  cms
UNION ALL
SELECT
  _TABLE_SUFFIX AS client,
  2019 AS year,
  app AS cms,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2019_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2019_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  category = 'CMS'
GROUP BY
  client,
  total,
  cms
ORDER BY
  year DESC,
  pct DESC
