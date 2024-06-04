#standardSQL
# 13_02: % of eCommerce tagged sites by device
## Carry 2019 and 2020 data in run
## This query is built using 2019 query from https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2019/13_Ecommerce/13_02b.sql but this commit fixes a flaw in 2019 query. See - https://github.com/HTTPArchive/almanac.httparchive.org/issues/1810
SELECT
  _TABLE_SUFFIX AS client,
  2020 AS year,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2020_08_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  category = 'Ecommerce'
GROUP BY
  client,
  total
UNION ALL
SELECT
  _TABLE_SUFFIX AS client,
  2019 AS year,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2019_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.summary_pages.2019_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  category = 'Ecommerce'
GROUP BY
  client,
  total
