#standardSQL
# Average Lighthouse scores (performance, accessibility, best-practices, SEO) for top CMS platforms within `httparchive.all.pages`

WITH score_data AS (
  SELECT
    client,
    page,
    t.technology AS cms,
    rank,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.performance.score') AS FLOAT64) AS performance_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.accessibility.score') AS FLOAT64) AS accessibility_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories["best-practices"].score') AS FLOAT64) AS best_practices_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.seo.score') AS FLOAT64) AS seo_score
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS t,
    UNNEST(t.categories) AS category
  WHERE
    date = '2024-06-01' AND
    lighthouse IS NOT NULL AND 
    lighthouse != '{}' AND
    is_root_page AND
    category = 'CMS'
)

SELECT
  cms,
  ROUND(AVG(performance_score) * 100, 2) AS avg_performance_score,
  ROUND(AVG(accessibility_score) * 100, 2) AS avg_accessibility_score,
  ROUND(AVG(best_practices_score) * 100, 2) AS avg_best_practices_score,
  ROUND(AVG(seo_score) * 100, 2) AS avg_seo_score,
  COUNT(DISTINCT page) AS total_pages
FROM
  score_data
GROUP BY
  cms
ORDER BY
  avg_performance_score DESC;
