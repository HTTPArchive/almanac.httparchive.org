#standardSQL
# Purpose
#   Measure the share of sites with a search input field, by client and root-page flag,
#   for the 2025-07-01 HTTP Archive crawl.
#
# What it does
#   • Parses the `almanac.input_elements` JSON (2025 location, with legacy fallback).
#   • Flags whether a page has any input elements and whether any qualify as "search":
#       - <input type="search">
#       - <input type="text"> whose placeholder starts with “search”.
#   • Rolls results up to (client, is_root_page).
#
# Outputs
#   • total_sites                   — distinct pages sampled
#   • total_with_inputs             — pages with ≥1 input element
#   • total_with_search_input       — pages with a search input
#   • perc_sites_with_search_input  — percent of all sites with a search input
#   • perc_input_sites_with_search_input — percent of sites with inputs that include a search input
#
# Notes
#   • Percentages are formatted as strings (e.g., "21.9%").
#   • SAFE_DIVIDE guards against division-by-zero when no sites match.
#   • Keep TABLESAMPLE for cheap test runs; remove/comment for full accuracy.

CREATE TEMPORARY FUNCTION hasSearchInput(almanac_str STRING)
RETURNS BOOL
LANGUAGE js AS r'''
  try {
    const almanac = JSON.parse(almanac_str || '{}');
    const nodes = almanac?.input_elements?.nodes;
    if (!Array.isArray(nodes)) return false;

    return nodes.some((node) => {
      const type = String(node?.type || '').toLowerCase();
      const ph   = String(node?.placeholder || '');
      if (type === 'search') return true;
      if (type === 'text' && /^\s*search(\s|$)/i.test(ph)) return true;
      return false;
    });
  } catch (_) {
    return false;
  }
''';

WITH base AS (
  SELECT
    client,
    is_root_page,
    COALESCE(
      TO_JSON_STRING(custom_metrics.other.almanac),   -- 2025 location
      JSON_EXTRACT_SCALAR(payload, '$._almanac')      -- legacy fallback
    ) AS almanac_str
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)
  WHERE date = DATE '2025-07-01'
),
flags AS (
  SELECT
    client,
    is_root_page,
    SAFE_CAST(JSON_VALUE(almanac_str, '$.input_elements.total') AS INT64) > 0 AS has_inputs,
    hasSearchInput(almanac_str) AS has_search_input
  FROM base
)
SELECT
  client,
  is_root_page,
  COUNT(*) AS total_sites,
  COUNTIF(has_inputs) AS total_with_inputs,
  COUNTIF(has_search_input) AS total_with_search_input,

  -- Percent of all sites with a search input
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNTIF(has_search_input), COUNT(*))
  ) AS perc_sites_with_search_input,

  -- Among sites that have inputs, percent that have a search input
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNTIF(has_search_input),
                           NULLIF(COUNTIF(has_inputs), 0))
  ) AS perc_input_sites_with_search_input
FROM flags
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
