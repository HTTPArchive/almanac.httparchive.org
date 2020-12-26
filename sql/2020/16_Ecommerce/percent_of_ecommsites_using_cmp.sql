#standardSQL
# 13_17a: % of eCommerce Sites by CMPs
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2020_08_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    url
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
     category = 'Ecommerce'
    )
USING
  (_TABLE_SUFFIX, url)
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
     category = 'Ecommerce'
  GROUP BY
    _TABLE_SUFFIX
    )
USING
  (_TABLE_SUFFIX)
WHERE
  category = 'Cookie compliance'
GROUP BY
  client,
  total
