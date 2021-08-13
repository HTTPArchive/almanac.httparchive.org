#standardSQL
# 13_15c: List of CDNs used by vendor usage for eComm - solely from Wapp
SELECT
  _TABLE_SUFFIX AS client,
  vendor,
  app,
  COUNTIF(category = 'CDN') AS Cdnfreq,
  SUM(COUNT(0)) OVER (PARTITION BY vendor) AS total,
  ROUND(COUNTIF(category = 'CDN') * 100 / SUM(COUNT(0)) OVER (PARTITION BY vendor), 2) AS pct
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
  client,
  vendor,
  app
HAVING
  Cdnfreq > 0
ORDER BY
  total DESC,
  Vendor,
  CdnFreq DESC
