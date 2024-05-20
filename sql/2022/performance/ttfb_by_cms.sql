SELECT
  app,
  client,
  COUNT(DISTINCT origin) AS n,
  SUM(IF(ttfb.start < 800, ttfb.density, 0)) / SUM(ttfb.density) AS fast,
  SUM(IF(ttfb.start >= 800 AND ttfb.start < 1800, ttfb.density, 0)) / SUM(ttfb.density) AS avg,
  SUM(IF(ttfb.start >= 1800, ttfb.density, 0)) / SUM(ttfb.density) AS slow
FROM
  `chrome-ux-report.all.202206`,
  UNNEST(experimental.time_to_first_byte.histogram.bin) AS ttfb
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'CMS'
)
ON
  client = IF(form_factor.name = 'desktop', 'desktop', 'mobile') AND
  CONCAT(origin, '/') = url
GROUP BY
  app,
  client
ORDER BY
  n DESC
