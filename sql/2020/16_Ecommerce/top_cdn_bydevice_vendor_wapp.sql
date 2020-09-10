#standardSQL
# 13_15b: % of CDN usage for eComm - solely from Wapp
SELECT
  vendor,
  COUNTIF(category = 'CDN') AS Cdnfreq,
  COUNT(0) AS total,
  ROUND(COUNTIF(category = 'CDN') * 100 / COUNT(0), 2) AS pct
  FROM
    `httparchive.sample_data.technologies_*`
JOIN 
(
  SELECT url, app as vendor
  FROM
    `httparchive.sample_data.technologies_*`
  WHERE
    category = 'Ecommerce'
 )
USING 
  (url)
GROUP BY
  vendor
 HAVING Cdnfreq > 0
ORDER BY
  pct desc