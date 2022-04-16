#standardSQL
# 13_11b: List of AD Platforms used by vendor usage for eComm - solely from Wapp
SELECT
  _TABLE_SUFFIX AS client,
  vendor,
  app,
  COUNTIF(category = 'Advertising') AS AdPlatfromFreq,
  SUM(COUNT(0)) OVER (PARTITION BY vendor) AS total,
  COUNTIF(category = 'Advertising') / SUM(COUNT(0)) OVER (PARTITION BY vendor) AS pct
FROM
  `httparchive.technologies.2021_07_01_*`
JOIN
  (
    SELECT
      _TABLE_SUFFIX AS client,
      url,
      app AS vendor
    FROM
      `httparchive.technologies.2021_07_01_*`
    WHERE
      category = 'Ecommerce' AND
      (
        app != 'Cart Functionality' AND
        app != 'Google Analytics Enhanced eCommerce'
      )
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
