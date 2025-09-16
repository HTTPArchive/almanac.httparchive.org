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

WITH src AS (
  /* ===== SAMPLE (enable this for quick/dev runs) ===== 
  SELECT
    client,
    page,
    is_root_page,
    lighthouse,
    technologies
  FROM `httparchive.sample_data.pages_10k`
  */

  /* ===== LIVE (disable SAMPLE above and enable this for prod runs) ===== */
  SELECT
    client,
    page,
    is_root_page,
    lighthouse,
    technologies
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-07-01'
),

score_data AS (
  SELECT
    p.client,
    p.page,
    LOWER(t.technology) AS cms_key,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.performance.score')      AS FLOAT64) AS performance_score,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.accessibility.score')    AS FLOAT64) AS accessibility_score,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.best-practices.score')   AS FLOAT64) AS best_practices_score,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.seo.score')              AS FLOAT64) AS seo_score
  FROM src AS p
  CROSS JOIN UNNEST(IFNULL(p.technologies, [])) AS t
  CROSS JOIN UNNEST(IFNULL(t.categories, [])) AS category
  WHERE
    p.is_root_page
    AND p.lighthouse IS NOT NULL
    AND JSON_TYPE(p.lighthouse) = 'object'
    AND category = 'CMS'
),

cms_named AS (
  SELECT
    client,
    page,
    CASE cms_key
      WHEN 'asciidoc'                     THEN 'AsciiDoc'
      WHEN 'godaddy website builder'      THEN 'GoDaddy Website Builder'
      WHEN 'opentext web solutions'       THEN 'OpenText Web Solutions'
      WHEN 'textpattern cms'              THEN 'Textpattern CMS'
      WHEN 'phpsqlitecms'                 THEN 'phpSQLiteCMS'
      WHEN 'phprs'                         THEN 'phpRS'
      WHEN 'cmsimple'                      THEN 'CMSimple'
      WHEN 'cppcms'                        THEN 'CppCMS'
      WHEN 'nexusphp'                      THEN 'NexusPHP'
      WHEN 'smartsite'                     THEN 'SmartSite'
      WHEN 'sitepark infosite'             THEN 'Sitepark InfoSite'
      WHEN 'sitepark ies'                  THEN 'Sitepark IES'
      ELSE INITCAP(cms_key)
    END AS cms,
    performance_score,
    accessibility_score,
    best_practices_score,
    seo_score
  FROM score_data
),

agg AS (
  SELECT
    cms,
    AVG(performance_score)     AS avg_perf,
    AVG(accessibility_score)   AS avg_a11y,
    AVG(best_practices_score)  AS avg_bp,
    AVG(seo_score)             AS avg_seo,
    COUNT(DISTINCT page)       AS total_pages
  FROM cms_named
  GROUP BY cms
)

SELECT
  cms,
  FORMAT('%.0f%%', 100 * avg_perf) AS avg_performance_score,
  FORMAT('%.0f%%', 100 * avg_a11y) AS avg_accessibility_score,
  FORMAT('%.0f%%', 100 * avg_bp)   AS avg_best_practices_score,
  FORMAT('%.0f%%', 100 * avg_seo)  AS avg_seo_score,
  total_pages
FROM agg
ORDER BY total_pages DESC;
