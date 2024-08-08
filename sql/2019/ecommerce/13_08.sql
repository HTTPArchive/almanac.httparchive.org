#standardSQL
# 13_08: CrUX FCP performance of ecommerce providers
SELECT
  app,
  COUNT(DISTINCT origin) AS freq,
  IF(form_factor.name = 'desktop', 'desktop', 'mobile') AS form_factor,
  ROUND(SUM(IF(bin.start < 1000, bin.density, 0)) / SUM(bin.density), 4) AS fast,
  ROUND(SUM(IF(bin.start >= 1000 AND bin.start < 2500, bin.density, 0)) / SUM(bin.density), 4) AS avg,
  ROUND(SUM(IF(bin.start >= 2500, bin.density, 0)) / SUM(bin.density), 4) AS slow
FROM
  `chrome-ux-report.all.201907`,
  UNNEST(first_contentful_paint.histogram.bin) AS bin
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    app
  FROM
    `httparchive.technologies.2019_07_01_*`
  WHERE
    category = 'Ecommerce'
  GROUP BY
    client,
    url,
    app
)
ON
  CONCAT(origin, '/') = url AND
  IF(form_factor.name = 'desktop', 'desktop', 'mobile') = client
GROUP BY
  app,
  form_factor
ORDER BY
  freq DESC
