#lighthouse category scores per cms
SELECT
  app AS cms,
  COUNT(DISTINCT url) AS freq,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.performance.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_performance,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.accessibility.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_accessibility,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.pwa.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_pwa,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.seo.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_seo,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.best-practices.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_best_practices
FROM
  `httparchive.lighthouse.2021_07_01_mobile`
JOIN
  `httparchive.technologies.2021_07_01_mobile`
USING
  (url)
WHERE
  category = 'CMS'
GROUP BY
  cms
ORDER BY
  freq DESC
