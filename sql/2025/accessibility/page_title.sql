#standardSQL
-- Web Almanac — Page title stats via Lighthouse “document‑title” audit
--
-- What this does
--   • Uses the Lighthouse audit “document-title” to determine if a page has a <title>.
--   • Aggregates per {client, is_root_page} the total pages, pages with a title, and percentage.
--   • Avoids `_wpt_bodies` entirely, so it works whether or not the property exists.
--
-- How to run
--   • SAMPLE (default): reads from `httparchive.sample_data.pages_10k`.
--   • LIVE: swap in the LIVE block (uncomment it, comment the SAMPLE block).
--   • Adjust the run_date in the params CTE for a different crawl date.
--
-- Notes
--   • Bracket JSON paths (`$."audits"."document-title"."score"`) handle hyphens safely.
--   • Percentages are formatted (e.g. “98.1%”). Raw fractions are not returned.
--   • `is_root_page` is included so root‑page and non‑root stats are separate.

WITH params AS (
  SELECT DATE '2025-07-01' AS run_date
),

/* =========================
   SAMPLE (default, cheap)
   ========================= 
src AS (
  SELECT
    client,
    is_root_page,
    CAST(JSON_VALUE(lighthouse, '$."audits"."document-title"."score"') AS FLOAT64) AS doc_title_score
  FROM `httparchive.sample_data.pages_10k`
  WHERE lighthouse IS NOT NULL AND JSON_TYPE(lighthouse) = 'object'
) */

-- Uncomment this block and comment out the SAMPLE block above to use the live crawl
src AS (
  SELECT
    p.client,
    p.is_root_page,
    CAST(JSON_VALUE(p.lighthouse, '$."audits"."document-title"."score"') AS FLOAT64) AS doc_title_score
  FROM `httparchive.crawl.pages` AS p
  CROSS JOIN params
  WHERE p.date = params.run_date
    AND p.is_root_page
    AND p.lighthouse IS NOT NULL
    AND JSON_TYPE(p.lighthouse) = 'object'
)

SELECT
  client,
  is_root_page,
  COUNT(*) AS total_sites,
  COUNTIF(doc_title_score = 1) AS total_has_title,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(doc_title_score = 1), COUNT(*))) AS pct_with_title
FROM src
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
