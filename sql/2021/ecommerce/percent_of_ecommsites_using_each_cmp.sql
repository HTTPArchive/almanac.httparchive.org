#standardSQL
# 13_17b: % CMP solutions share on eCommerce origins broken down by device
SELECT
  _TABLE_SUFFIX AS client,
  app,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2021_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'Ecommerce'
)
USING (_TABLE_SUFFIX, url)
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'Ecommerce'
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  category = 'Cookie compliance'
GROUP BY
  client,
  app,
  total
ORDER BY
  client,
  pct DESC
