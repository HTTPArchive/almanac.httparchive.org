#standardSQL
-- Web Almanac — Lighthouse category scores by framework (2025-07-01)
--
-- What this does
--   • Extracts Lighthouse category scores (performance, accessibility,
--     best-practices, SEO) from JSON.
--   • Associates each page with detected frontend frameworks or JS libraries.
--   • Averages scores per {client, framework}, avoiding duplicate page-framework rows.
--   • Outputs scores as human-readable percentages.
--
-- Output columns
--   client                  — "desktop" | "mobile"
--   framework               — framework or library name (e.g., jQuery, React)
--   avg_performance_score   — average % performance score
--   avg_accessibility_score — average % accessibility score
--   avg_best_practices_score — average % best-practices score
--   avg_seo_score           — average % SEO score
--   total_pages             — number of distinct pages per {client, framework}

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
    -- TABLESAMPLE SYSTEM (0.1 PERCENT)   -- ← optional: cheap smoke test
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
),

-- De-dupe: average per page+framework before global averaging
per_page_framework AS (
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

SELECT
  client,
  framework,
  FORMAT('%.2f%%', 100 * AVG(performance_score))    AS avg_performance_score,
  FORMAT('%.2f%%', 100 * AVG(accessibility_score))  AS avg_accessibility_score,
  FORMAT('%.2f%%', 100 * AVG(best_practices_score)) AS avg_best_practices_score,
  FORMAT('%.2f%%', 100 * AVG(seo_score))            AS avg_seo_score,
  COUNT(DISTINCT page)                              AS total_pages
FROM per_page_framework
GROUP BY client, framework
ORDER BY total_pages DESC;
