#standardSQL
# Web Almanac — % of pages having skip links
#
# Purpose
#   Estimate the share of pages that expose an early “skip link” anchor,
#   using the SEO anchor-elements signal `earlyHash`.
#
# Metric definition
#   A page “has skip link” iff: almanac["seo-anchor-elements"].earlyHash > 0
#
# Grouping
#   Results per {client, is_root_page}.
#
# Data sources
#   • Primary (2025): custom_metrics.other.almanac (JSON-typed)
#   • Fallback (legacy 2024): payload._almanac (STRING)
#   Path: $.["seo-anchor-elements"].earlyHash
#
# Output
#   • pages  — pages with earlyHash > 0
#   • total  — total pages
#   • pct    — formatted percentage of pages with skip link
#
# Notes
#   • SAFE_CAST + JSON_VALUE handle missing/invalid JSON.
#   • Use TABLESAMPLE for smoke tests; remove for full run.
#   • Hyphenated keys require quoted JSON paths.
#

WITH base AS (
  SELECT
    client,
    is_root_page,
    COALESCE(
      TO_JSON_STRING(custom_metrics.other.almanac),   -- 2025 location
      JSON_EXTRACT_SCALAR(payload, '$._almanac')      -- legacy fallback
    ) AS almanac_str
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)                -- enable for cheap tests
  WHERE date = DATE '2025-07-01'
),

per_page AS (
  SELECT
    client,
    is_root_page,
    SAFE_CAST(
      JSON_VALUE(almanac_str, '$."seo-anchor-elements".earlyHash')
      AS INT64
    ) AS early_hash
  FROM base
)

SELECT
  client,
  is_root_page,
  COUNTIF(early_hash > 0) AS pages,
  COUNT(*)                AS total,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(early_hash > 0), COUNT(*))) AS pct
FROM per_page
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
