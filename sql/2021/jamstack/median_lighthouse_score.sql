#standardSQL
# Lighthouse category scores per SSG
SELECT
  ssg,
  COUNT(DISTINCT url) AS freq,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.performance.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_performance,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.accessibility.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_accessibility,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.pwa.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_pwa,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.seo.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_seo,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$."best-practices".score') AS NUMERIC), 1000)[OFFSET(500)] AS median_best_practices
FROM (
  SELECT
    url,
    JSON_EXTRACT(report, '$.categories') AS categories
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`)
JOIN (
  SELECT DISTINCT
    app AS ssg,
    url
  FROM
    `httparchive.technologies.2021_07_01_mobile`
  WHERE
    LOWER(category) = "static site generator" OR
    app = "Next.js" OR
    app = "Nuxt.js")
USING
  (url)
GROUP BY
  ssg
ORDER BY
  freq DESC
