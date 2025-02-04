#standardSQL
# 13_20: Lighthouse category scores per eCommerce plaforms. Web Almanac run LightHouse only in mobile mode and hence references to mobile tables
SELECT
  _TABLE_SUFFIX AS client,
  app AS ecommVendor,
  COUNT(DISTINCT url) AS freq,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.performance.score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_performance,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.accessibility.score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_accessibility,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.pwa.score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_pwa,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.seo.score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_seo,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.best-practices.score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_best_practices
FROM
  `httparchive.lighthouse.2022_06_01_*`
JOIN
  `httparchive.technologies.2022_06_01_*`
USING (url, _TABLE_SUFFIX)
WHERE
  category = 'Ecommerce' AND (
    app != 'Cart Functionality' AND
    app != 'Google Analytics Enhanced eCommerce'
  )
GROUP BY
  client,
  ecommVendor
ORDER BY
  client,
  freq DESC
