#standardSQL
# 13_14: % of AMP enabled eCommerce Sites
SELECT
  _TABLE_SUFFIX AS client,
  vendor,
  app,
  COUNTIF(category = 'AMP') AS AMPfromFreq,
  SUM(COUNT(0)) OVER (PARTITION BY vendor) AS total,
  ROUND(COUNTIF(category = 'AMP') * 100 / SUM(COUNT(0)) OVER (PARTITION BY vendor), 2) AS pct
  FROM
    `httparchive.technologies.2020_08_01_*`
JOIN 
(
  SELECT 
    _TABLE_SUFFIX AS client,
    url, 
    app as vendor
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
    category = 'Ecommerce'
 )
USING 
  (url)
GROUP BY
  client, 
  vendor, 
  app
HAVING 
 AMPFreq > 0
ORDER BY
  total desc,
  Vendor, 
  AMPFreq desc
  