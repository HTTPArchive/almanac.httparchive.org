#standardSQL
# 13_06: Distribution of image stats
SELECT
  client,
  format,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.summary_requests`
JOIN (
  SELECT DISTINCT _TABLE_SUFFIX AS client, url AS page
  FROM `httparchive.technologies.2022_06_01_*`
  WHERE category = 'Ecommerce' AND (
      app != 'Cart Functionality' AND
      app != 'Google Analytics Enhanced eCommerce'
    )
)
USING (client, page)
WHERE
  type = 'image'
GROUP BY
  client,
  format
ORDER BY
  freq / total DESC
