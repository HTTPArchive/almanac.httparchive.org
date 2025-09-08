#standardSQL
# Web Almanac — Form controls with placeholder but no label
#
# Purpose
#   Measure how often sites use <input> placeholders without providing a label.
#   This captures cases where form controls rely solely on placeholder text,
#   which is an accessibility anti-pattern.
#
# Metrics (per {client, is_root_page}):
#   • total_sites                         — total pages in the slice
#   • sites_with_placeholder              — pages with ≥1 placeholder input
#   • sites_with_no_label                 — pages with ≥1 placeholder lacking a label
#   • pct_sites_with_placeholder          — share of all pages that use any placeholders
#   • pct_placeholder_sites_with_no_label — share of placeholder-using pages that lack labels
#   • total_placeholders                  — total number of placeholder inputs
#   • total_placeholder_with_no_label     — number of placeholder inputs lacking labels
#   • pct_placeholders_with_no_label      — share of placeholders without labels
#
# Data source
#   • httparchive.crawl.pages (crawl date = 2025-07-01).
#   • JSON path: custom_metrics.a11y.placeholder_but_no_label
#       - Fields: total_placeholder, total_no_label
#   • Fallbacks:
#       - custom_metrics.other.a11y
#       - legacy payload._a11y
#
# Output
#   Counts are INT64.
#   Percentages are pre-formatted strings (e.g. "55.2%").

WITH base AS (
  SELECT
    client,
    is_root_page,
    -- Prefer 2025 JSON locations; last resort is legacy payload._a11y (string)
    COALESCE(
      TO_JSON_STRING(custom_metrics.a11y),
      TO_JSON_STRING(custom_metrics.other.a11y),
      JSON_EXTRACT_SCALAR(payload, '$._a11y')
    ) AS a11y_str
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)           -- remove for full run
  WHERE date = DATE '2025-07-01'
),

flags AS (
  SELECT
    client,
    is_root_page,
    SAFE_CAST(JSON_VALUE(a11y_str, '$.placeholder_but_no_label.total_placeholder') AS INT64)
      AS total_placeholder,
    SAFE_CAST(JSON_VALUE(a11y_str, '$.placeholder_but_no_label.total_no_label') AS INT64)
      AS total_no_label
  FROM base
)

SELECT
  client,
  is_root_page,

  COUNT(*) AS total_sites,

  COUNTIF(total_placeholder > 0) AS sites_with_placeholder,
  COUNTIF(total_no_label > 0)    AS sites_with_no_label,

  -- % of all sites that have any placeholders
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNTIF(total_placeholder > 0), COUNT(*))
  ) AS pct_sites_with_placeholder,

  -- Among sites with placeholders, % that also have placeholders lacking labels
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(
                 COUNTIF(total_no_label > 0),
                 NULLIF(COUNTIF(total_placeholder > 0), 0)
               )
  ) AS pct_placeholder_sites_with_no_label,

  -- Totals across pages (placeholders and those lacking labels)
  SUM(total_placeholder) AS total_placeholders,
  SUM(total_no_label)    AS total_placeholder_with_no_label,

  -- % of placeholders that lack labels
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(
                 SUM(total_no_label),
                 NULLIF(SUM(total_placeholder), 0)
               )
  ) AS pct_placeholders_with_no_label

FROM flags
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
