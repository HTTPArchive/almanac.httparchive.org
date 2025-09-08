#standardSQL
# Web Almanac — Table stats: total, captioned, presentational (2025 only, formatted like 2024)
#
# Purpose
#   For each {client, is_root_page}, report:
#     • sites_with_table                  — pages with ≥1 <table>
#     • sites_with_captions               — pages with ≥1 captioned table
#     • sites_with_presentational         — pages with ≥1 presentational table
#     • pct_sites_with_table              — % of pages having tables
#     • pct_table_sites_with_captioned    — among table sites, % with captions
#     • pct_table_sites_with_presentational — among table sites, % with presentational tables
#     • total_tables, total_captioned, total_presentational (page-summed)
#     • pct_captioned, pct_presentational — shares over total tables
#
# Data
#   Table: httparchive.crawl.pages
#   Date:  2025-07-01
#   Field: custom_metrics.a11y.tables.*  (JSON-typed)
#
# Notes
#   • Percentages are formatted strings (e.g., "16.1%").
#   • Keep TABLESAMPLE commented for smoke tests; remove for production.

WITH base AS (
  SELECT
    client,
    is_root_page,
    TO_JSON_STRING(custom_metrics.a11y) AS a11y_str
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)  -- enable for cheap tests only
  WHERE date = DATE '2025-07-01'
),

flags AS (
  SELECT
    client,
    is_root_page,
    SAFE_CAST(JSON_VALUE(a11y_str, '$.tables.total') AS INT64)                         AS total_tables,
    SAFE_CAST(JSON_VALUE(a11y_str, '$.tables.total_with_caption') AS INT64)            AS total_captioned,
    SAFE_CAST(JSON_VALUE(a11y_str, '$.tables.total_with_presentational') AS INT64)     AS total_presentational
  FROM base
)

SELECT
  client,
  is_root_page,

  COUNT(*) AS total_sites,

  COUNTIF(total_tables > 0)         AS sites_with_table,
  COUNTIF(total_captioned > 0)      AS sites_with_captions,
  COUNTIF(total_presentational > 0) AS sites_with_presentational,

  -- page-level percentages (formatted)
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(total_tables > 0),        COUNT(*)))                         AS pct_sites_with_table,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(total_captioned > 0),     NULLIF(COUNTIF(total_tables > 0), 0))) AS pct_table_sites_with_captioned,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(total_presentational > 0),NULLIF(COUNTIF(total_tables > 0), 0))) AS pct_table_sites_with_presentational,

  -- totals across all pages
  SUM(total_tables)         AS total_tables,
  SUM(total_captioned)      AS total_captioned,
  SUM(total_presentational) AS total_presentational,

  -- table-level percentages (formatted)
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(SUM(total_captioned),      NULLIF(SUM(total_tables), 0))) AS pct_captioned,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(SUM(total_presentational), NULLIF(SUM(total_tables), 0))) AS pct_presentational

FROM flags
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
