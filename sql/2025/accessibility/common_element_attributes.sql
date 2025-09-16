-- standardSQL
-- Web Almanac — % of sites using each attribute (sample table; 2024-style output)
--
-- What this does
--   • Reads the 2025-style JSON blob at: custom_metrics.other.almanac  (JSON-typed)
--   • Extracts attribute names from: almanac.attributes_used_on_elements (object of {attribute: count})
--   • Computes, per {client, is_root_page}, the % of (sample) sites that use each attribute
--   • Always includes ARIA attributes; also includes any non-ARIA attribute used by ≥ 1% of sites
--
-- Output columns (mirrors 2024 structure)
--   client, is_root_page, total_sites, attribute, total_sites_using, pct_sites_using
--   - pct_sites_using is a human-readable string like "25.0%".
--   - If you ever need a numeric 0..1 ratio for math/plots, you can re-add pct_sites_using_num,
--     but it's intentionally omitted here to match your preference and avoid confusion.
--
-- Notes
--   • No TABLESAMPLE or deterministic hashing used.
--   • If the sample table lacks a 'date' column, keep the date filter commented out.
--   • We wrap JSON (type JSON) with TO_JSON_STRING(...) to pass into the JS UDF safely.
--
CREATE TEMPORARY FUNCTION getUsedAttributes(almanac_str STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS r"""
try {
  const almanac = JSON.parse(almanac_str || "{}");
  const m = almanac.attributes_used_on_elements;
  if (!m || typeof m !== "object") return [];
  return Object.keys(m); // attribute names present on the page
} catch (e) {
  return [];
}
""";

WITH attribute_usage AS (
  SELECT
    p.client,
    p.is_root_page,
    p.page,
    attr AS attribute
  FROM `httparchive.crawl.pages` AS p
  CROSS JOIN UNNEST(
    getUsedAttributes(TO_JSON_STRING(p.custom_metrics.other.almanac))
  ) AS attr
  WHERE 1=1
    AND p.date = DATE '2025-07-01'           
    AND p.custom_metrics.other.almanac IS NOT NULL
),
totals AS (
  SELECT
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total_sites
  FROM attribute_usage
  GROUP BY client, is_root_page
)

SELECT
  a.client,
  a.is_root_page,
  t.total_sites,                                   -- denominator per {client, is_root_page}
  a.attribute,
  COUNT(DISTINCT a.page) AS total_sites_using,     -- sites (in this sample) that used this attribute
  -- pct_sites_using_num intentionally omitted to keep only human-readable percentage
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNT(DISTINCT a.page), t.total_sites)) AS pct_sites_using
FROM attribute_usage a
JOIN totals t
  ON a.client = t.client AND a.is_root_page = t.is_root_page
GROUP BY a.client, a.is_root_page, t.total_sites, a.attribute
HAVING
  STARTS_WITH(a.attribute, 'aria-')
  OR SAFE_DIVIDE(COUNT(DISTINCT a.page), t.total_sites) >= 0.01   -- ≥ 1% of sites (in this sample)
ORDER BY
  SAFE_DIVIDE(COUNT(DISTINCT a.page), t.total_sites) DESC,
  a.client, a.is_root_page, a.attribute;
