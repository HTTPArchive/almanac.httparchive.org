#standardSQL
# 13_02: % of eCommerce tagged sites by device
## Carry 2019 and 2020 data in run
SELECT
  _TABLE_SUFFIX AS client,
   2020 AS year,
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
  category = 'Ecommerce'
--    and 
--  app != 'Cart Functionality'
GROUP BY
  client,
  total
UNION ALL
SELECT
  _TABLE_SUFFIX AS client,
   2019 AS year,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.technologies.2019_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2019_07_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (_TABLE_SUFFIX)
WHERE
  category = 'Ecommerce'
GROUP BY
  client,
  total