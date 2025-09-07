#standardSQL
-- Web Almanac — Average Lighthouse scores (performance, accessibility, best-practices, SEO) by CMS
--
-- What this does
--   • Extracts four Lighthouse category scores from JSON: performance, accessibility,
--     best-practices, and SEO.
--   • Filters to root pages from the July 1, 2025 crawl.
--   • Expands `technologies` → `categories` and keeps only those where category = 'CMS'.
--   • Normalizes CMS names to lowercase.
--   • Aggregates per CMS: average score in each category and count of distinct pages.
--
-- Notes
--   • SAMPLE vs LIVE: uncomment `TABLESAMPLE SYSTEM (0.1 PERCENT)` in `score_data` for cheap smoke tests,
--     or remove it for the full crawl.
--   • Scores are reported on a 0..1 scale; no percentage formatting applied here.
--   • CMS detection depends on Wappalyzer’s `technologies` classification.
--
-- Output columns
--   cms                     — normalized CMS technology name
--   avg_performance_score   — mean Lighthouse performance score across pages
--   avg_accessibility_score — mean Lighthouse accessibility score
--   avg_best_practices_score — mean Lighthouse best-practices score
--   avg_seo_score           — mean Lighthouse SEO score
--   total_pages             — number of distinct root pages for that CMS

WITH score_data AS (
  SELECT
    p.client,
    p.page,
    LOWER(t.technology) AS cms,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.performance.score')      AS FLOAT64) AS performance_score,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.accessibility.score')    AS FLOAT64) AS accessibility_score,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.best-practices.score')   AS FLOAT64) AS best_practices_score,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.seo.score')              AS FLOAT64) AS seo_score
  FROM `httparchive.crawl.pages` AS p
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)  -- adjust as needed for SMOKE TESTS
  CROSS JOIN UNNEST(p.technologies) AS t
  CROSS JOIN UNNEST(t.categories) AS category
  WHERE
    p.date = DATE '2025-07-01'
    AND p.is_root_page
    AND p.lighthouse IS NOT NULL
    AND JSON_TYPE(p.lighthouse) = 'object'   -- ensure valid JSON object
    AND category = 'CMS'
)

SELECT
  cms,
  AVG(performance_score)     AS avg_performance_score,
  AVG(accessibility_score)   AS avg_accessibility_score,
  AVG(best_practices_score)  AS avg_best_practices_score,
  AVG(seo_score)             AS avg_seo_score,
  COUNT(DISTINCT page)       AS total_pages
FROM score_data
GROUP BY cms
ORDER BY avg_performance_score DESC;
