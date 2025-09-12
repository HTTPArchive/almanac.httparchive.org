-- standardSQL
-- Web Almanac — Adoption of :focus and outline:0 (full crawl tables, partition-safe)
--
-- What this does
--   • Denominator = all pages on 2025-07-01 from httparchive.crawl.pages (by client).
--   • Numerator   = pages (same date) whose parsed CSS contains :focus, and those that also set outline:0.
--   • pc.css is JSON-typed → pass as STRING to the JS UDF via TO_JSON_STRING(pc.css).
--   • REQUIRED: partition filter on httparchive.crawl.parsed_css (pc.date).
--
-- Output
--   client, pages_focus, pages_focus_outline_0, total_pages,
--   pct_pages_focus, pct_pages_focus_outline_0

CREATE TEMPORARY FUNCTION detectFocusOutline0(css_str STRING)
RETURNS STRUCT<has_focus BOOL, has_outline0 BOOL>
LANGUAGE js AS r"""
try {
  const s = String(css_str || "");
  const hasFocus    = /:focus\b/i.test(s);
  const hasOutline0 = /outline\s*:\s*0\b/i.test(s);
  return { has_focus: hasFocus, has_outline0: (hasFocus && hasOutline0) };
} catch (e) {
  return { has_focus: false, has_outline0: false };
}
""";

WITH pages AS (
  SELECT client, page
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-07-01'
),
css_signals AS (
  SELECT
    pc.client,
    pc.page,
    LOGICAL_OR(sig.has_focus)    AS has_focus,
    LOGICAL_OR(sig.has_outline0) AS has_outline0
  FROM `httparchive.crawl.parsed_css` AS pc
  CROSS JOIN UNNEST([detectFocusOutline0(TO_JSON_STRING(pc.css))]) AS sig
  WHERE pc.date = DATE '2025-07-01'   -- partition filter must come AFTER the joins
  GROUP BY pc.client, pc.page
)
SELECT
  p.client,
  COUNTIF(s.has_focus)    AS pages_focus,
  COUNTIF(s.has_outline0) AS pages_focus_outline_0,
  COUNT(*)                AS total_pages,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(s.has_focus),    COUNT(*))) AS pct_pages_focus,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(s.has_outline0), COUNT(*))) AS pct_pages_focus_outline_0
FROM pages p
LEFT JOIN css_signals s USING (client, page)
GROUP BY p.client
ORDER BY SAFE_DIVIDE(COUNTIF(s.has_focus), COUNT(*)) DESC;

