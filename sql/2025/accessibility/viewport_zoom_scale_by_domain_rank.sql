#standardSQL
-- Viewport zoom/scale usage by domain rank
-- Toggles:
--   1) SAMPLE vs LIVE data in `src`
--   2) CUMULATIVE vs BUCKETED output at the very bottom

WITH src AS (
  /* ======== SAMPLE (fast/dev) ========
  SELECT
    client,
    is_root_page,
    payload,
    custom_metrics.other AS cm_other,
    rank
  FROM `httparchive.sample_data.pages_10k`
  */

  /* ======== LIVE (full crawl) ========   */
  SELECT
    client,
    is_root_page,
    payload,
    custom_metrics.other AS cm_other,
    rank
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-07-01'

),

extracted AS (
  SELECT
    client,
    is_root_page,
    rank,
    ARRAY_CONCAT(
      COALESCE(JSON_QUERY_ARRAY(cm_other, '$.almanac."meta-nodes".nodes'), ARRAY<JSON>[]),
      COALESCE(JSON_QUERY_ARRAY(cm_other, '$."wpt_bodies"."meta-nodes".nodes'), ARRAY<JSON>[])
    ) AS meta_nodes,
    JSON_VALUE(payload, '$._meta_viewport') AS legacy_meta_viewport
  FROM src
),

per_page AS (
  SELECT
    client,
    is_root_page,
    rank,
    (
      EXISTS (
        SELECT 1
        FROM UNNEST(meta_nodes) n
        WHERE LOWER(JSON_VALUE(n, '$.tagName')) = 'meta'
          AND LOWER(JSON_VALUE(n, '$.name'))    = 'viewport'
      )
      OR legacy_meta_viewport IS NOT NULL
    ) AS has_meta_viewport,

    (
      EXISTS (
        SELECT 1
        FROM UNNEST(meta_nodes) n
        WHERE LOWER(JSON_VALUE(n, '$.tagName')) = 'meta'
          AND LOWER(JSON_VALUE(n, '$.name'))    = 'viewport'
          AND REGEXP_CONTAINS(
                LOWER(COALESCE(JSON_VALUE(n, '$.content'), '')),
                r'\buser-scalable\s*=\s*(no|0)\b'
              )
      )
      OR REGEXP_CONTAINS(
            LOWER(COALESCE(legacy_meta_viewport, '')),
            r'\buser-scalable\s*=\s*(no|0)\b'
         )
    ) AS not_scalable,

    (
      EXISTS (
        SELECT 1
        FROM UNNEST(meta_nodes) n
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
),

-- Rank thresholds to report
thresholds AS (
  SELECT * FROM UNNEST([
    1000, 10000, 100000, 1000000, 10000000, 100000000
  ]) AS rank_grouping
),

thresholds_with_prev AS (
  SELECT
    rank_grouping,
    LAG(rank_grouping) OVER (ORDER BY rank_grouping) AS prev_group
  FROM thresholds
),

/* =========================
   CUMULATIVE (≤ rank_grouping)
   ========================= */
cum AS (
  SELECT
    p.client,
    p.is_root_page,
    t.rank_grouping,
    COUNT(*)                                         AS total_pages,
    COUNTIF(p.has_meta_viewport)                    AS total_viewports,
    COUNTIF(p.not_scalable)                         AS total_no_scale,
    COUNTIF(p.max_scale_1_or_less)                  AS total_locked_max_scale,
    COUNTIF(p.not_scalable OR p.max_scale_1_or_less) AS total_either
  FROM per_page p
  JOIN thresholds t
    ON p.rank <= t.rank_grouping
  GROUP BY p.client, p.is_root_page, t.rank_grouping
),

/* =========================
   BUCKETED ((prev, current])
   ========================= */
bucket AS (
  SELECT
    p.client,
    p.is_root_page,
    twp.rank_grouping,
    COUNT(*)                                         AS total_pages,
    COUNTIF(p.has_meta_viewport)                    AS total_viewports,
    COUNTIF(p.not_scalable)                         AS total_no_scale,
    COUNTIF(p.max_scale_1_or_less)                  AS total_locked_max_scale,
    COUNTIF(p.not_scalable OR p.max_scale_1_or_less) AS total_either
  FROM per_page p
  JOIN thresholds_with_prev twp
    ON p.rank > IFNULL(twp.prev_group, 0)
   AND p.rank <= twp.rank_grouping
  GROUP BY p.client, p.is_root_page, twp.rank_grouping
),

fmt_cum AS (
  SELECT
    client,
    is_root_page,
    rank_grouping,
    total_pages,
    total_viewports,
    total_no_scale,
    total_locked_max_scale,
    total_either,
    -- SAFE_DIVIDE(total_no_scale, total_pages)                        AS pct_pages_no_scale,
    -- SAFE_DIVIDE(total_locked_max_scale, total_pages)                 AS pct_pages_locked_max_scale,
    -- SAFE_DIVIDE(total_either, total_pages)                           AS pct_pages_either,
    FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_no_scale, total_pages))        AS pct_pages_no_scale_str,
    FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_locked_max_scale, total_pages)) AS pct_pages_locked_max_scale_str,
    FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_either, total_pages))           AS pct_pages_either_str
  FROM cum
),

fmt_bucket AS (
  SELECT
    client,
    is_root_page,
    rank_grouping,
    total_pages,
    total_viewports,
    total_no_scale,
    total_locked_max_scale,
    total_either,
    SAFE_DIVIDE(total_no_scale, total_pages)                        AS pct_pages_no_scale,
    SAFE_DIVIDE(total_locked_max_scale, total_pages)                 AS pct_pages_locked_max_scale,
    SAFE_DIVIDE(total_either, total_pages)                           AS pct_pages_either,
    FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_no_scale, total_pages))        AS pct_pages_no_scale_str,
    FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_locked_max_scale, total_pages)) AS pct_pages_locked_max_scale_str,
    FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_either, total_pages))           AS pct_pages_either_str
  FROM bucket
)

-- ===========================
-- FINAL OUTPUT: pick ONE
-- ===========================

-- ===== Use this SELECT for CUMULATIVE (≤ N) — comparable to your 2024-style table =====
SELECT * FROM fmt_cum
ORDER BY client, is_root_page, rank_grouping;

-- ===== Or use this SELECT for BUCKETED ((prev, N]) bins =====
-- SELECT * FROM fmt_bucket
-- ORDER BY client, is_root_page, rank_grouping;
