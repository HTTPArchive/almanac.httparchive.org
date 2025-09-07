#standardSQL
-- Web Almanac — Average Lighthouse scores by Web framework/library (per client)
--
-- What this does
--   • Identifies pages using popular front-end tech (frameworks/libs) from Wappalyzer’s `technologies`.
--   • Extracts Lighthouse category scores (performance, accessibility, best-practices, SEO).
--   • Dedupes to one row per {client, page, framework}, then aggregates per {client, framework}.
--   • Outputs raw averages (0..1), formatted percentages, and a distinct page count.
--
-- How to run
--   • Toggle SAMPLE (cheap, uses `httparchive.sample_data.pages_10k`) vs LIVE (full crawl) by
--     switching the `src_base` block below.
--   • Set the crawl date in the `params` CTE when using LIVE.
--
-- Notes
--   • The Lighthouse column is JSON-typed; never compare it to '{}' (a string). Instead use
--       JSON_TYPE(lighthouse) = 'object'
--     and extract with JSON_VALUE using bracketed keys for hyphenated names:
--       JSON_VALUE(lighthouse, '$."categories"."best-practices"."score"')
--   • Framework selection is based on Wappalyzer categories containing any of:
--       'Web frameworks', 'Frontend frameworks', 'JavaScript frameworks', 'JavaScript libraries'.
--   • Scores are per page; multiple tech matches for a page are deduped by averaging per page+framework
--     (equivalent to taking ANY_VALUE since category scores don’t vary within a page).

WITH
params AS (
  SELECT
    DATE '2025-07-01' AS run_date
),

/* =========================
   SAMPLE (default, cheap)
   ========================= 
src_base AS (
  SELECT
    p.client,
    p.page,
    LOWER(t.technology) AS framework,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."performance"."score"')      AS FLOAT64) AS performance_score,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."accessibility"."score"')    AS FLOAT64) AS accessibility_score,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"')   AS FLOAT64) AS best_practices_score,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."seo"."score"')              AS FLOAT64) AS seo_score
  FROM `httparchive.sample_data.pages_10k` AS p
  CROSS JOIN UNNEST(p.technologies) AS t
  CROSS JOIN UNNEST(t.categories)   AS cat
  WHERE
    p.lighthouse IS NOT NULL
    AND JSON_TYPE(p.lighthouse) = 'object'
    AND cat IN ('Web frameworks','Frontend frameworks','JavaScript frameworks','JavaScript libraries')
    AND t.technology IS NOT NULL
) */

/* =========================
   LIVE (full crawl)
   -- Swap this block in, and comment the SAMPLE block above
   ========================= */
src_base AS (
  SELECT
    p.client,
    p.page,
    LOWER(t.technology) AS framework,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."performance"."score"')      AS FLOAT64) AS performance_score,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."accessibility"."score"')    AS FLOAT64) AS accessibility_score,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"')   AS FLOAT64) AS best_practices_score,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."seo"."score"')              AS FLOAT64) AS seo_score
  FROM `httparchive.crawl.pages` AS p, params
  CROSS JOIN UNNEST(p.technologies) AS t
  CROSS JOIN UNNEST(t.categories)   AS cat
  WHERE
    p.date = params.run_date
    AND p.is_root_page
    AND p.lighthouse IS NOT NULL
    AND JSON_TYPE(p.lighthouse) = 'object'
    AND cat IN ('Web frameworks','Frontend frameworks','JavaScript frameworks','JavaScript libraries')
    AND t.technology IS NOT NULL
)

, per_page_framework AS (
  -- Dedupe: one record per {client, page, framework}
  SELECT
    client,
    page,
    framework,
    AVG(performance_score)    AS performance_score,
    AVG(accessibility_score)  AS accessibility_score,
    AVG(best_practices_score) AS best_practices_score,
    AVG(seo_score)            AS seo_score
  FROM src_base
  GROUP BY client, page, framework
)

-- Final output (one SELECT)
SELECT
  client,
  framework,
  COUNT(DISTINCT page)                           AS total_pages,
  FORMAT('%.0f%%', 100*AVG(performance_score))   AS avg_performance_pct,
  FORMAT('%.0f%%', 100*AVG(accessibility_score)) AS avg_accessibility_pct,
  FORMAT('%.0f%%', 100*AVG(best_practices_score))AS avg_best_practices_pct,
  FORMAT('%.0f%%', 100*AVG(seo_score))           AS avg_seo_pct
FROM per_page_framework
GROUP BY client, framework
ORDER BY total_pages DESC, client, framework;
