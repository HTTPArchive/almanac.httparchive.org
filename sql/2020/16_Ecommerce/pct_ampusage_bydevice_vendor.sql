#standardSQL
# 13_14: % of AMP enabled eCommerce Sites by device
SELECT
  _TABLE_SUFFIX AS client,
  vendor,
  COUNTIF(app = 'AMP') AS AMPFreq,
  SUM(COUNT(0)) OVER (PARTITION BY vendor) AS total,
  ROUND(COUNTIF(app = 'AMP') * 100 / SUM(COUNT(0)) OVER (PARTITION BY vendor), 2) AS pct
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
  vendor
ORDER BY
  total desc,
  AMPFreq desc,
  Vendor
  