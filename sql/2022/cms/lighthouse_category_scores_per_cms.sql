#standardSQL
# Lighthouse category scores per CMS
SELECT
  client,
  cms,
  COUNT(DISTINCT url) AS freq,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.performance.score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_performance,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.accessibility.score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_accessibility,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.pwa.score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_pwa,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.seo.score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_seo,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$."best-practices".score') AS NUMERIC), 1000)[OFFSET(500)] * 100 AS median_best_practices
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_EXTRACT(report, '$.categories') AS categories
  FROM
    `httparchive.lighthouse.2022_06_01_*`
)
JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    app AS cms,
    url
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'CMS'
)
USING (url, client)
GROUP BY
  client,
  cms
ORDER BY
  freq DESC,
  client
