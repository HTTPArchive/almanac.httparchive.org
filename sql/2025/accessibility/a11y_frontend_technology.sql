#standardSQL
-- Web Almanac — Lighthouse category scores by framework (2025-07-01)
-- Google Sheet: a11y_frontend_technology
--
-- Purpose
--   • Extract Lighthouse category scores (performance, accessibility,
--     best-practices, SEO) from JSON in the crawl dataset.
--   • Associate each crawled page with detected frontend frameworks or JS libraries.
--   • Limit to root pages only for consistency.
--   • De-duplicate multiple {page, framework} rows caused by UNNEST, by averaging
--     scores per page before computing framework-level averages.
--
-- Method
--   1. Extract scores with JSON_EXTRACT_SCALAR, cast to FLOAT64.
--   2. Filter to categories: Web frameworks, JavaScript libraries,
--      Frontend frameworks, JavaScript frameworks.
--   3. Aggregate in two steps:
--        a. Per {client, page, framework}, average scores to remove duplicates.
--        b. Global averages per {client, framework}.
--
-- Output columns
--   client                   — "desktop" | "mobile"
--   framework                — detected framework or JS library
--   avg_performance_score    — average Lighthouse performance score (0–1)
--   avg_accessibility_score  — average Lighthouse accessibility score (0–1)
--   avg_best_practices_score — average Lighthouse best-practices score (0–1)
--   avg_seo_score            — average Lighthouse SEO score (0–1)
--   total_pages              — distinct page count per {client, framework}
--
-- Notes
--   • Scores remain in 0–1 float scale (not percentages).
--   • `is_root_page = TRUE` ensures only root URLs are included.
--   • Optional: enable TABLESAMPLE for faster smoke testing.
WITH score_data AS (
  SELECT
    client,
    page,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.performance.score') AS FLOAT64) AS performance_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.accessibility.score') AS FLOAT64) AS accessibility_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.best-practices.score') AS FLOAT64) AS best_practices_score,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.seo.score') AS FLOAT64) AS seo_score,
    t.technology AS framework
  FROM
    `httparchive.crawl.pages`,
    -- TABLESAMPLE SYSTEM (0.1 PERCENT)   -- ← optional: cheap smoke test
    UNNEST(technologies) AS t
  WHERE
    date = '2025-07-01' AND
    lighthouse IS NOT NULL AND
    -- lighthouse != '{}' AND
    is_root_page = TRUE AND
    ('Web frameworks' IN UNNEST(t.categories) OR 'JavaScript libraries' IN UNNEST(t.categories) OR 'Frontend frameworks' IN UNNEST(t.categories) OR 'JavaScript frameworks' IN UNNEST(t.categories)) AND
    t.technology IS NOT NULL
)

SELECT
  client,
  framework,
  AVG(performance_score) AS avg_performance_score,
  AVG(accessibility_score) AS avg_accessibility_score,
  AVG(best_practices_score) AS avg_best_practices_score,
  AVG(seo_score) AS avg_seo_score,
  COUNT(DISTINCT page) AS total_pages
FROM (
  SELECT
    client,
    page,
    framework,
    AVG(performance_score) AS performance_score, # All scores are the same for one page (we have multiple rows due to unnest), we could also take the first instead of the average
    AVG(accessibility_score) AS accessibility_score,
    AVG(best_practices_score) AS best_practices_score,
    AVG(seo_score) AS seo_score
  FROM
    score_data
  GROUP BY
    client,
    page,
    framework
)
GROUP BY
  client,
  framework
ORDER BY
  total_pages DESC;
