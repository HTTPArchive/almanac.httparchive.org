#standardSQL
-- Web Almanac — Media query features: % of pages using each feature
--
-- What this does
--   • Parses parsed_css ASTs to collect @media feature names (e.g., width, prefers-color-scheme).
--   • Aggregates per client: #pages using each feature, total pages, and % of pages.
--   • Supports cheap SMOKE TEST (sample tables) or full LIVE crawl via a CTE switch.
--
-- How to run
--   • SAMPLE (default): uses httparchive.sample_data.parsed_css_10k + pages_10k (no date column).
--   • LIVE: uncomment the LIVE block and comment out the SAMPLE block; set run_date as needed.
--
-- Notes
--   • css-utils.js expects a CSS AST; pass TO_JSON_STRING(css) defensively.
--   • LIVE parsed_css is partitioned by date; a date filter is required.
--   • Percent is returned both as a raw fraction and a formatted string.

CREATE TEMPORARY FUNCTION getMediaQueryFeatures(css_str STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS r"""
try {
  const ast = JSON.parse(css_str || "{}");
  const counts = {};
  walkRules(ast, rule => {
    if (!rule || typeof rule.media !== "string") return;
    // Collect feature names inside parentheses before ':' or ')'
    let features = rule.media.replace(/\s+/g, "").match(/\(([A-Za-z0-9_-]+)(?=[:\)])/g);
    if (!features) return;
    features = features.map(s => s.slice(1));
    for (const f of features) incrementByKey(counts, String(f).toLowerCase());
  }, { type: "media" });
  return Object.keys(counts);
} catch (e) {
  return [];
}
""";

WITH
/* =========================
SAMPLE (default, cheap)
=========================
css_features AS (
  SELECT
    pc.client,
    pc.page,
    feature
  FROM `httparchive.sample_data.parsed_css_10k` AS pc
  CROSS JOIN UNNEST(getMediaQueryFeatures(TO_JSON_STRING(pc.css))) AS feature
  WHERE feature IS NOT NULL
  GROUP BY pc.client, pc.page, feature
),
totals AS (
  SELECT
    p.client,
    COUNT(*) AS total_pages
  FROM `httparchive.sample_data.pages_10k` AS p
  GROUP BY p.client
) */

/* =========================
   LIVE (full crawl)
   -- Swap this in and comment the SAMPLE block above */
css_features AS (
  SELECT
    pc.client,
    pc.page,
    feature
  FROM `httparchive.crawl.parsed_css` AS pc
  CROSS JOIN UNNEST(getMediaQueryFeatures(TO_JSON_STRING(pc.css))) AS feature
  WHERE pc.date = DATE '2025-07-01'
    AND feature IS NOT NULL
  GROUP BY pc.client, pc.page, feature
),
totals AS (
  SELECT
    p.client,
    COUNT(*) AS total_pages
  FROM `httparchive.crawl.pages` AS p
  WHERE p.date = DATE '2025-07-01'
    -- AND p.is_root_page  -- remove if you want all pages
  GROUP BY p.client
)


-- =======================
-- Final output (one SELECT)
-- =======================
SELECT
  f.client,
  f.feature,
  COUNT(DISTINCT f.page) AS pages,
  t.total_pages,
  SAFE_DIVIDE(COUNT(DISTINCT f.page), t.total_pages)                        AS pct_pages_with_feature,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNT(DISTINCT f.page), t.total_pages)) AS pct_pages_with_feature_fmt
FROM css_features AS f
JOIN totals AS t
  ON t.client = f.client
GROUP BY f.client, f.feature, t.total_pages
HAVING pages >= 100
ORDER BY pct_pages_with_feature DESC, f.client, f.feature;
