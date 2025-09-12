#standardSQL
# Web Almanac — Disabled zooming and scaling via the viewport tag (robust 2025+ schema)
#
# What this query measures (page-level flags)
#   - total_pages: all pages in the sample
#   - total_viewports: pages that have ANY <meta name="viewport" ...>
#   - total_no_scale: pages where ANY viewport has user-scalable=no|0
#   - total_locked_max_scale: pages where ANY viewport has maximum-scale <= 1
#   - total_either: pages that match either of the above restrictions
#
# Why this is robust
#   - 2025+ data stores <meta> tags under custom_metrics.other.*:
#       • $.almanac["meta-nodes"].nodes[*]
#       • $."wpt_bodies"["meta-nodes"].nodes[*]
#   - Older/legacy crawls sometimes had payload._meta_viewport (a single string).
#   - This query checks all of the above and merges them.
#
# Safety / formatting
#   - Percentages use SAFE_DIVIDE to avoid "division by zero".
#   - Percent columns are formatted as X.Y%.
#
# How to use
#   - Change the date below as needed.
#   - Keep TABLESAMPLE for smoke tests; remove it for full runs.

WITH base AS (
  SELECT
    client,
    is_root_page,
    -- Raw JSON blobs we’ll mine into
    custom_metrics.other AS cm_other,   -- STRING-encoded JSON
    payload                      AS payload_json
  FROM `httparchive.crawl.pages` 
    -- TABLESAMPLE SYSTEM (0.1 PERCENT)  -- enable for cheap tests only
  WHERE date = DATE '2025-07-01'
),

extracted AS (
  SELECT
    client,
    is_root_page,

    -- Gather all <meta> nodes from BOTH "almanac" and "wpt_bodies".
    -- If a path is missing, JSON_QUERY_ARRAY() returns NULL, so coalesce to [] and concat.
    ARRAY_CONCAT(
      COALESCE(JSON_QUERY_ARRAY(cm_other, '$.almanac."meta-nodes".nodes'), ARRAY<JSON>[]),
      COALESCE(JSON_QUERY_ARRAY(cm_other, '$."wpt_bodies"."meta-nodes".nodes'), ARRAY<JSON>[])
    ) AS meta_nodes,

    -- Legacy single-value viewport string (may be NULL/empty)
    JSON_VALUE(payload_json, '$._meta_viewport') AS legacy_meta_viewport
  FROM base
),

per_page AS (
  SELECT
    client,
    is_root_page,

    -- Does the page have ANY viewport meta (either from nodes or legacy string)?
    (
      EXISTS (
        SELECT 1
        FROM UNNEST(meta_nodes) AS n
        WHERE LOWER(JSON_VALUE(n, '$.tagName')) = 'meta'
          AND LOWER(JSON_VALUE(n, '$.name'))    = 'viewport'
      )
      OR legacy_meta_viewport IS NOT NULL
    ) AS has_meta_viewport,

    -- user-scalable = no|0 (from any node or legacy string)
    (
      EXISTS (
        SELECT 1
        FROM UNNEST(meta_nodes) AS n
        WHERE LOWER(JSON_VALUE(n, '$.tagName')) = 'meta'
          AND LOWER(JSON_VALUE(n, '$.name'))    = 'viewport'
          AND REGEXP_CONTAINS(
                LOWER(COALESCE(JSON_VALUE(n, '$.content'), '')),
                r'\buser-scalable\s*=\s*(no|0)\b'
              )
      )
      OR REGEXP_CONTAINS(LOWER(COALESCE(legacy_meta_viewport, '')),
                         r'\buser-scalable\s*=\s*(no|0)\b')
    ) AS not_scalable,

    -- maximum-scale <= 1 (from any node or legacy string)
    (
      EXISTS (
        SELECT 1
        FROM UNNEST(meta_nodes) AS n
        WHERE LOWER(JSON_VALUE(n, '$.tagName')) = 'meta'
          AND LOWER(JSON_VALUE(n, '$.name'))    = 'viewport'
          AND SAFE_CAST(
                REGEXP_EXTRACT(
                  LOWER(COALESCE(JSON_VALUE(n, '$.content'), '')),
                  r'maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)'
                ) AS FLOAT64
              ) <= 1
      )
      OR SAFE_CAST(
            REGEXP_EXTRACT(
              LOWER(COALESCE(legacy_meta_viewport, '')),
              r'maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)'
            ) AS FLOAT64
          ) <= 1
    ) AS max_scale_1_or_less
  FROM extracted
)

SELECT
  client,
  is_root_page,
  COUNT(*)                                           AS total_pages,
  COUNTIF(has_meta_viewport)                         AS total_viewports,
  COUNTIF(not_scalable)                              AS total_no_scale,
  COUNTIF(max_scale_1_or_less)                       AS total_locked_max_scale,
  COUNTIF(not_scalable OR max_scale_1_or_less)       AS total_either,

  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(not_scalable), COUNT(*)))                     AS pct_pages_no_scale,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(max_scale_1_or_less), COUNT(*)))              AS pct_pages_locked_max_scale,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(not_scalable OR max_scale_1_or_less), COUNT(*))) AS pct_pages_either
FROM per_page
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
