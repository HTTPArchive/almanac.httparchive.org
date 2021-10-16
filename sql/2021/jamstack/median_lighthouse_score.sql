#standardSQL
# Lighthouse category scores per SSG
SELECT
  _TABLE_SUFFIX AS client,
  app AS ssg,
  COUNT(DISTINCT url) AS freq,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.performance.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_performance,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.accessibility.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_accessibility,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, '$.categories.pwa.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_pwa
FROM
  `httparchive.lighthouse.2021_07_01_*`
JOIN
  `httparchive.technologies.2021_07_01_*`
USING
  (_TABLE_SUFFIX, url)
WHERE
  LOWER(category) = "static site generator" OR
  app = "Next.js" OR
  app = "Nuxt.js"
GROUP BY
  ssg,
  client
ORDER BY
  freq DESC
