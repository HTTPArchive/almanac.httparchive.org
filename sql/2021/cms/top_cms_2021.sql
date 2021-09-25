#standardSQL
# Top CMS platforms, compared to 2020
SELECT
  _TABLE_SUFFIX AS client,
  2021 AS year,
  app AS cms,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.technologies.2021_08_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_08_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (_TABLE_SUFFIX)
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
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.technologies.2020_08_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (_TABLE_SUFFIX)
WHERE
  category = 'CMS'
GROUP BY
  client,
  total,
  cms
ORDER BY
  year DESC,
  pct DESC
