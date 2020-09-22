#standardSQL
# 13_11b: List of Analtics Platforms used by vendor usage for eComm - solely from Wapp
SELECT
  _TABLE_SUFFIX AS client,
  vendor,
  app,
  COUNTIF(category = 'Analytics') AS AnalyticsPlatformFreq,
  SUM(COUNT(0)) OVER (PARTITION BY vendor) AS total,
  ROUND(COUNTIF(category = 'Analytics') * 100 / SUM(COUNT(0)) OVER (PARTITION BY vendor), 2) AS pct
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
 AnalyticsPlatfromFreq > 0
ORDER BY
  total desc,
  Vendor, 
  AnalyticsPlatformFreq desc
  