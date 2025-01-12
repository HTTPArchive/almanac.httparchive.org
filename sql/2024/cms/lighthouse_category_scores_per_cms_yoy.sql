#standardSQL
# Lighthouse category scores per CMS YoY
# lighthouse_category_scores_per_cms_yoy.sql
SELECT
  CASE
    WHEN date = '2024-06-01' THEN '2024'
    ELSE '2023'
  END AS year,
  client,
  cms,
  COUNT(DISTINCT url) AS freq,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.performance.score') AS NUMERIC), 1000)[
    OFFSET(500)
  ] * 100 AS median_performance,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.accessibility.score') AS NUMERIC), 1000)[
    OFFSET(500)
  ] * 100 AS median_accessibility,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$.seo.score') AS NUMERIC), 1000)[
    OFFSET(500)
  ] * 100 AS median_seo,
  APPROX_QUANTILES(CAST(JSON_VALUE(categories, '$."best-practices".score') AS NUMERIC), 1000)[
    OFFSET(500)
  ] * 100 AS median_best_practices
FROM (
  SELECT
    client,
    date,
    page AS url,
    JSON_EXTRACT(lighthouse, '$.categories') AS categories
  FROM
    `httparchive.all.pages`
  WHERE
    (date = '2024-06-01' OR date = '2023-06-01') AND
    is_root_page
)
JOIN (
  SELECT DISTINCT
    client,
    date,
    technologies.technology AS cms,
    page AS url
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    (date = '2024-06-01' OR date = '2023-06-01') AND
    is_root_page
)
USING (date, url, client)
GROUP BY
  date,
  client,
  cms
ORDER BY
  date,
  client,
  freq DESC
