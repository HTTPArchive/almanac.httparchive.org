#standardSQL
# Web Almanac — Sites using the role attribute
#
# Purpose
#   Measure adoption of the global HTML `role` attribute and summarize the distribution
#   of role usage counts per page. Results are split by client and root-page flag,
#   while totals are shown per client (desktop/mobile) to match 2024 tables.
#
# Metrics
#   • total_sites       — total pages for the client (desktop/mobile), shown on every row
#   • total_using_role  — pages with ≥ 1 role attribute (per client)
#   • pct_using_role    — total_using_role / total_sites, formatted like "74.3%"
#   • total_role_usages — per-group (client, is_root_page) approximate quantiles of
#                         total role attributes on a page at percentiles: 10,25,50,75,90,100
#
# Data
#   • Table: httparchive.crawl.pages
#   • Date: 2025-07-01
#   • JSON path (2025): custom_metrics.other.almanac.nodes_using_role.total
#   • Fallback (legacy): payload._almanac.nodes_using_role.total
#
# Notes
#   • Percentiles computed with APPROX_QUANTILES over each (client, is_root_page) group.
#   • Totals per client are computed once in a window over the grouped rows.
#   • Use TABLESAMPLE for cheap smoke tests; remove for production.
#   • SAFE_CAST/JSON_VALUE used to avoid parse errors.
#

WITH base AS (
  SELECT
    client,
    is_root_page,
    COALESCE(
      TO_JSON_STRING(custom_metrics.other.almanac),
      JSON_EXTRACT_SCALAR(payload, '$._almanac')
    ) AS almanac_str
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)
  WHERE date = DATE '2025-07-01'
),

per_page AS (
  SELECT
    client,
    is_root_page,
    SAFE_CAST(JSON_VALUE(almanac_str, '$.nodes_using_role.total') AS INT64) AS total_role_attributes
  FROM base
),

-- Aggregate per (client, is_root_page): counts and full quantile array once
group_stats AS (
  SELECT
    client,
    is_root_page,
    COUNT(*) AS pages_in_group,
    COUNTIF(total_role_attributes > 0) AS pages_with_role,
    APPROX_QUANTILES(total_role_attributes, 1000) AS q1000
  FROM per_page
  GROUP BY client, is_root_page
),

-- Compute client-level totals once, via window over the grouped rows
with_client_totals AS (
  SELECT
    client,
    is_root_page,
    pages_in_group,
    pages_with_role,
    -- client totals (same value on TRUE/FALSE rows for that client)
    SUM(pages_in_group)    OVER (PARTITION BY client) AS total_sites_client,
    SUM(pages_with_role)   OVER (PARTITION BY client) AS total_using_role_client,
    q1000
  FROM group_stats
)

SELECT
  client,
  is_root_page,
  total_sites_client     AS total_sites,
  total_using_role_client AS total_using_role,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_using_role_client, NULLIF(total_sites_client, 0))) AS pct_using_role,
  percentile,
  -- APPROX_QUANTILES returns 1001 entries (0..1000). Index = percentile * 10.
  q1000[OFFSET(CAST(percentile * 10 AS INT64))] AS total_role_usages
FROM with_client_totals,
UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
ORDER BY percentile, client, is_root_page;
