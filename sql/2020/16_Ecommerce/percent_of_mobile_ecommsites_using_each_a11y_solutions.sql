#standardSQL
# 13_18b: % A11Y overlay solutions on mobile eCommerce origins
SELECT
  _TABLE_SUFFIX AS client,
  app,
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
    `httparchive.technologies.2020_08_01_*`
  WHERE
     category = 'Ecommerce'
  GROUP BY
    _TABLE_SUFFIX
    )
USING
  (_TABLE_SUFFIX)
WHERE
  category = 'Accessibility'
  and _TABLE_SUFFIX = 'mobile'
GROUP BY
  client,
  app,
  total
order by
  pct desc