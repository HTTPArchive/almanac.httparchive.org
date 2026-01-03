#standardSQL
# Average Lighthouse scores (performance, accessibility, best-practices, SEO) for top CMS platforms within `httparchive.crawl.pages`

WITH score_data AS (
  SELECT
    client,
    page,
    t.technology AS cms,
    rank,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.performance.score') AS FLOAT64) AS performance_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.accessibility.score') AS FLOAT64) AS accessibility_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.best-practices.score') AS FLOAT64) AS best_practices_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.seo.score') AS FLOAT64) AS seo_score
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS t,
    UNNEST(t.categories) AS category
  WHERE
    date = '2025-07-01' AND
    lighthouse IS NOT NULL AND
    lighthouse.categories IS NOT NULL AND
    is_root_page AND
    category = 'CMS'
)

SELECT
  cms,
  AVG(performance_score) AS avg_performance_score,
  AVG(accessibility_score) AS avg_accessibility_score,
  AVG(best_practices_score) AS avg_best_practices_score,
  AVG(seo_score) AS avg_seo_score,
  COUNT(DISTINCT page) AS total_pages
FROM
  score_data
GROUP BY
  cms
ORDER BY
  avg_performance_score DESC;
