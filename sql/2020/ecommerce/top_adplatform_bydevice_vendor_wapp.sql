#standardSQL
# 13_11b: List of AD Platforms used by vendor usage for eComm - solely from Wapp
SELECT
  _TABLE_SUFFIX AS client,
  vendor,
  app,
  COUNTIF(category = 'Advertising') AS AdPlatfromFreq,
  SUM(COUNT(0)) OVER (PARTITION BY vendor) AS total,
  ROUND(COUNTIF(category = 'Advertising') * 100 / SUM(COUNT(0)) OVER (PARTITION BY vendor), 2) AS pct
  FROM
    `httparchive.technologies.2020_08_01_*`
JOIN
(
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    app AS vendor
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
    category = 'Ecommerce'
 )
USING
  (url)
GROUP BY
  client, vendor, app
HAVING
 AdPlatfromFreq > 0
ORDER BY
  total DESC,
  Vendor,
  AdPlatfromFreq DESC
