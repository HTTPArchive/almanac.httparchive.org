#standardSQL
-- Web Almanac — Average Lighthouse scores per geo (country) and device
--
-- What this does
--   • Maps origins to country (`geo`) and device (`client`) from CrUX country_summary.
--   • Joins HTTP Archive Lighthouse scores (by host) and computes averages per {geo, client}.
--   • Extracts category scores for performance, accessibility, best-practices, SEO.
--   • Outputs raw averages (0..1), formatted percentages, and a host count.
--
-- How to run (comparability tips)
--   • Set `crux_yyyymm` to the CrUX month you used previously (e.g., 202406 for June 2024).
--   • Set `run_date` to the HA crawl date you want (e.g., 2024-06-01 for 2024, 2025-07-01 for 2025).
--   • Toggle SAMPLE (cheap smoke test) vs LIVE (full crawl) by switching the `src_base` block.
--
-- Notes
--   • Keys with hyphens use bracketed JSON paths:
--       JSON_VALUE(lighthouse, '$."categories"."best-practices"."score"')
--   • Host match uses REGEXP_EXTRACT host from both CrUX `origin` and HA `page`.
--   • Counts are per host (not registrable domain).

WITH
params AS (
  SELECT
    DATE '2025-07-01' AS run_date,   -- change to DATE '2024-06-01' to reproduce 2024
    202506            AS crux_yyyymm -- change to 202406 to reproduce 2024 (June 2024)
),

crux AS (
  SELECT
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS geo,
    IF(device = 'desktop', 'desktop', 'mobile')               AS client,
    origin,
    REGEXP_EXTRACT(origin, r'://([^/]+)')                     AS host
  FROM `chrome-ux-report.materialized.country_summary`, params
  WHERE yyyymm = params.crux_yyyymm
),

/* ===========================
   SAMPLE (default, cheap)
   =========================== 
src_base AS (
  SELECT
    REGEXP_EXTRACT(p.page, r'://([^/]+)') AS host,
    p.client,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."performance"."score"')     AS FLOAT64) AS perf,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."accessibility"."score"')   AS FLOAT64) AS a11y,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"')  AS FLOAT64) AS best_practices,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."seo"."score"')             AS FLOAT64) AS seo
  FROM `httparchive.sample_data.pages_10k` AS p, params
  WHERE
    p.lighthouse IS NOT NULL
    AND JSON_TYPE(p.lighthouse) = 'object'
    AND (
      JSON_VALUE(p.lighthouse, '$."categories"."performance"."score"')    IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$."categories"."accessibility"."score"')  IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"') IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$."categories"."seo"."score"')            IS NOT NULL
    )
) */

/* ===========================
   LIVE (full crawl)
   -- Swap this block in, and comment the SAMPLE block above
   =========================== */
src_base AS (
  SELECT
    REGEXP_EXTRACT(p.page, r'://([^/]+)') AS host,
    p.client,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."performance"."score"')     AS FLOAT64) AS perf,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."accessibility"."score"')   AS FLOAT64) AS a11y,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"')  AS FLOAT64) AS best_practices,
    CAST(JSON_VALUE(p.lighthouse, '$."categories"."seo"."score"')             AS FLOAT64) AS seo
  FROM `httparchive.crawl.pages` AS p, params
  WHERE
    p.date = params.run_date
    AND p.is_root_page
    AND p.lighthouse IS NOT NULL
    AND JSON_TYPE(p.lighthouse) = 'object'
    AND (
      JSON_VALUE(p.lighthouse, '$."categories"."performance"."score"')    IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$."categories"."accessibility"."score"')  IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$."categories"."best-practices"."score"') IS NOT NULL OR
      JSON_VALUE(p.lighthouse, '$."categories"."seo"."score"')            IS NOT NULL
    )
)


SELECT
  c.geo,
  c.client,
  COUNT(DISTINCT s.host)                        AS total_domains,
  FORMAT('%.0f%%', 100 * AVG(s.perf))           AS avg_performance_pct,
  FORMAT('%.0f%%', 100 * AVG(s.a11y))           AS avg_accessibility_pct,
  FORMAT('%.0f%%', 100 * AVG(s.best_practices)) AS avg_best_practices_pct,
  FORMAT('%.0f%%', 100 * AVG(s.seo))            AS avg_seo_pct
FROM crux c
JOIN src_base s
  ON c.host = s.host
 AND c.client = s.client
GROUP BY c.geo, c.client
ORDER BY c.geo ASC, c.client;
