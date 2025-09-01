-- This query analyzes Lighthouse category scores (performance, accessibility,
-- best-practices, SEO) for root pages in the HTTP Archive crawl on 2025-07-01.
-- It extracts scores from the JSON `lighthouse` field, associates each page
-- with detected frontend frameworks or JS libraries (via the `technologies`
-- array), and calculates the average scores per framework and client (desktop/mobile).
-- The results include:
--   • avg_performance_score
--   • avg_accessibility_score
--   • avg_best_practices_score
--   • avg_seo_score
--   • total_pages (distinct pages per framework/client)
-- Ordered by the frameworks with the most pages.

WITH score_data AS (
  SELECT
    client,
    page,
    SAFE_CAST(JSON_VALUE(lighthouse, '$.categories.performance.score') AS FLOAT64) AS performance_score,
    SAFE_CAST(JSON_VALUE(lighthouse, '$.categories.accessibility.score') AS FLOAT64) AS accessibility_score,
    SAFE_CAST(JSON_VALUE(lighthouse, '$.categories."best-practices".score') AS FLOAT64) AS best_practices_score,
    SAFE_CAST(JSON_VALUE(lighthouse, '$.categories.seo.score') AS FLOAT64) AS seo_score,
    t.technology AS framework
  FROM
    `httparchive.crawl.pages`
  CROSS JOIN
    UNNEST(technologies) AS t
  WHERE
    date = '2025-07-01'
    AND lighthouse IS NOT NULL
    AND JSON_TYPE(lighthouse) = 'object'
    AND (
      'Web frameworks'        IN UNNEST(t.categories) OR
      'JavaScript libraries'  IN UNNEST(t.categories) OR
      'Frontend frameworks'   IN UNNEST(t.categories) OR
      'JavaScript frameworks' IN UNNEST(t.categories)
    )
    AND t.technology IS NOT NULL
)
SELECT
  client,
  framework,
  AVG(performance_score)    AS avg_performance_score,
  AVG(accessibility_score)  AS avg_accessibility_score,
  AVG(best_practices_score) AS avg_best_practices_score,
  AVG(seo_score)            AS avg_seo_score,
  COUNT(DISTINCT page)      AS total_pages
FROM (
  SELECT
    client,
    page,
    framework,
    AVG(performance_score)    AS performance_score,
    AVG(accessibility_score)  AS accessibility_score,
    AVG(best_practices_score) AS best_practices_score,
    AVG(seo_score)            AS seo_score
  FROM score_data
  WHERE performance_score IS NOT NULL
  GROUP BY client, page, framework
)
GROUP BY client, framework
ORDER BY total_pages DESC;
