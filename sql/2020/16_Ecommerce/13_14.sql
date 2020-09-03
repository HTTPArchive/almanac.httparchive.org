#standardSQL
# 13_14: % of AMP enabled eCommerce Sites
SELECT
  vendor,
  COUNTIF(app = 'AMP') AS Ampfreq,
  COUNT(0) AS total,
  ROUND(COUNTIF(app = 'AMP') * 100 / COUNT(0), 2) AS pct
  FROM
    `httparchive.technologies.2020_08_01_mobile`
JOIN 
(
  SELECT url, app as vendor
  FROM
    `httparchive.technologies.2020_08_01_mobile`
  WHERE
    category = 'Ecommerce'
 )
USING 
  (url)
GROUP BY
  vendor
ORDER BY
  Ampfreq desc