#standardSQL
# Web Almanac — Sites using sr-only / visually-hidden classes
#
# Purpose
#   Share of pages that include “screen-reader-only” utility classes (e.g., sr-only, visually-hidden).
#
# Data
#   Source: httparchive.crawl.pages (2025-07-01)
#   JSON paths (new → old):
#     custom_metrics.a11y.screen_reader_classes
#     custom_metrics.other.a11y.screen_reader_classes
#     payload._a11y.screen_reader_classes   (legacy)
#
# Metric logic
#   uses_sr_only := screen_reader_classes is:
#     - boolean true, or
#     - non-empty object, or
#     - non-empty array
#
# Output (per {client, is_root_page})
#   total_sites (INT64)
#   sites_with_sr_only (INT64)
#   pct_sites_with_sr_only (formatted string, e.g. "16.0%")
#
WITH base AS (
  SELECT
    client,
    is_root_page,
    COALESCE(
      TO_JSON_STRING(custom_metrics.a11y),
      TO_JSON_STRING(custom_metrics.other.a11y),
      JSON_EXTRACT_SCALAR(payload, '$._a11y')          -- legacy
    ) AS a11y_str
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)                 -- enable for smoke tests
  WHERE date = DATE '2025-07-01'
),

parsed AS (
  SELECT
    client,
    is_root_page,
    SAFE.PARSE_JSON(a11y_str) AS a11y_json
  FROM base
),

flags AS (
  SELECT
    client,
    is_root_page,
    CASE
      WHEN JSON_TYPE(JSON_QUERY(a11y_json, '$.screen_reader_classes')) = 'boolean' THEN
        SAFE_CAST(JSON_VALUE(a11y_json, '$.screen_reader_classes') AS BOOL)
      WHEN JSON_TYPE(JSON_QUERY(a11y_json, '$.screen_reader_classes')) = 'object' THEN
        ARRAY_LENGTH(JSON_KEYS(JSON_QUERY(a11y_json, '$.screen_reader_classes'))) > 0
      WHEN JSON_TYPE(JSON_QUERY(a11y_json, '$.screen_reader_classes')) = 'array' THEN
        ARRAY_LENGTH(JSON_QUERY_ARRAY(a11y_json, '$.screen_reader_classes')) > 0
      ELSE FALSE
    END AS uses_sr_only
  FROM parsed
)

SELECT
  client,
  is_root_page,
  COUNT(*) AS total_sites,
  COUNTIF(uses_sr_only) AS sites_with_sr_only,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(uses_sr_only), COUNT(*))) AS pct_sites_with_sr_only
FROM flags
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
