#standardSQL
-- Web Almanac — Lighthouse scores grouped by top-level domain (TLD)
--
-- What this does
--   • Extracts host from each page, strips any :port, then takes the last dot label as TLD.
--   • Reads Lighthouse category scores (performance, accessibility, best-practices, SEO).
--   • Aggregates per TLD: averages (formatted as %) and page counts.
--
-- How to run
--   • SAMPLE (default): uses httparchive.sample_data.pages_10k (cheap & fast).
--   • LIVE: uncomment the LIVE block and comment the SAMPLE block.
--
-- Notes
--   • Don’t compare JSON to '{}' (a string). Use JSON_TYPE(lighthouse)='object' and JSON_VALUE(...).
--   • TLD extraction here is “last label of host after removing :port”. It’s a simplification and
--     not a full Public Suffix List decomposition.

WITH params AS (
  SELECT DATE '2025-07-01' AS run_date
),

/* =========================
   SAMPLE (default, cheap)
   ========================= 
src_base AS (
  SELECT
    -- Raw host and portless host
    REGEXP_EXTRACT(p.page, r'://([^/]+)')                                         AS host_raw,
    REGEXP_REPLACE(REGEXP_EXTRACT(p.page, r'://([^/]+)'), r':\d+$', '')           AS host_no_port,
    -- TLD = last dot label (after removing :port)
    REGEXP_EXTRACT(REGEXP_REPLACE(REGEXP_EXTRACT(p.page, r'://([^/]+)'), r':\d+$', ''), r'\.([^.]+)$') AS tld,

    -- Scores (0..1)
    CAST(JSON_VALUE(p.lighthouse, '$.categories.performance.score')         AS FLOAT64) AS perf,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.accessibility.score')       AS FLOAT64) AS a11y,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"') AS FLOAT64) AS best_practices,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.seo.score')                 AS FLOAT64) AS seo
  FROM `httparchive.sample_data.pages_10k` AS p
  WHERE p.lighthouse IS NOT NULL
    AND JSON_TYPE(p.lighthouse) = 'object'
    AND (
      JSON_VALUE(p.lighthouse, '$.categories.performance.score')           IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$.categories.accessibility.score')         IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"')  IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$.categories.seo.score')                   IS NOT NULL
    )
) */

/* =========================
   LIVE (full crawl)
   -- Swap this in and comment the SAMPLE block above
   ========================= */
src_base AS (
  SELECT
    REGEXP_EXTRACT(p.page, r'://([^/]+)')                                         AS host_raw,
    REGEXP_REPLACE(REGEXP_EXTRACT(p.page, r'://([^/]+)'), r':\d+$', '')           AS host_no_port,
    REGEXP_EXTRACT(REGEXP_REPLACE(REGEXP_EXTRACT(p.page, r'://([^/]+)'), r':\d+$', ''), r'\.([^.]+)$') AS tld,

    CAST(JSON_VALUE(p.lighthouse, '$.categories.performance.score')         AS FLOAT64) AS perf,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.accessibility.score')       AS FLOAT64) AS a11y,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"') AS FLOAT64) AS best_practices,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.seo.score')                 AS FLOAT64) AS seo
  FROM `httparchive.crawl.pages` AS p, params
  WHERE p.date = params.run_date
    AND p.is_root_page
    AND p.lighthouse IS NOT NULL
    AND JSON_TYPE(p.lighthouse) = 'object'
    AND (
      JSON_VALUE(p.lighthouse, '$.categories.performance.score')           IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$.categories.accessibility.score')         IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"')  IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$.categories.seo.score')                   IS NOT NULL
    )
)


-- =======================
-- Final output (one SELECT)
-- =======================
SELECT
  tld,
  FORMAT('%.1f%%', 100 * AVG(perf))            AS avg_performance_score,
  FORMAT('%.1f%%', 100 * AVG(a11y))            AS avg_accessibility_score,
  FORMAT('%.1f%%', 100 * AVG(best_practices))  AS avg_best_practices_score,
  FORMAT('%.1f%%', 100 * AVG(seo))             AS avg_seo_score,
  COUNT(*)                                      AS total_pages
FROM src_base
WHERE tld IS NOT NULL AND tld != ''
GROUP BY tld
ORDER BY avg_accessibility_score DESC, tld;
