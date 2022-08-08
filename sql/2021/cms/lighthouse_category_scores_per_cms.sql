#standardSQL
# Lighthouse category scores per CMS
SELECT
  cms,
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
    app AS cms,
    url
  FROM
    `httparchive.technologies.2021_07_01_mobile`
  WHERE
    category = 'CMS')
USING
  (url)
GROUP BY
  cms
ORDER BY
  freq DESC
