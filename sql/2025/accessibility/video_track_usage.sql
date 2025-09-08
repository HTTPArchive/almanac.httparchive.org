#standardSQL
# Web Almanac — Video elements with <track> usage (formatted percentages, 2025-first)
#
# Purpose
#   For each {client, is_root_page}, report:
#     • total_with_video            — pages with ≥ 1 <video>
#     • total_with_tracks           — pages with ≥ 1 <track> inside a <video>
#     • pct_videos_with_tracks      — SUM(video tracks) / SUM(videos)                [table-level]
#     • pct_sites_with_videos       — total_with_video / total_sites                 [page-level]
#     • pct_video_sites_with_tracks — total_with_tracks / total_with_video           [page-level among video sites]
#
# Data
#   Table:  httparchive.crawl.pages
#   Date:   2025-07-01
#   Fields (2025-first with optional fallbacks — delete the last COALESCE arm to enforce 2025-only):
#     - custom_metrics.other.almanac.videos.total
#     - custom_metrics.other.almanac.videos.total_with_track
#     - fallback: custom_metrics.markup.videos.* or payload._almanac.videos.*
#
# Safety
#   • All ratios use SAFE_DIVIDE with NULLIF to avoid 0/0.
#   • Percentages are formatted strings (e.g., "0.5%").
#   • Keep TABLESAMPLE commented out unless you’re doing smoke tests.

WITH base AS (
  SELECT
    client,
    is_root_page,
    SAFE_CAST(
      COALESCE(
        JSON_VALUE(TO_JSON_STRING(custom_metrics.other.almanac), '$.videos.total'),
        JSON_VALUE(TO_JSON_STRING(custom_metrics.markup),        '$.videos.total'),
        JSON_EXTRACT_SCALAR(payload,                             '$._almanac.videos.total')            -- legacy fallback; remove if 2025-only
      ) AS INT64
    ) AS total_videos,
    SAFE_CAST(
      COALESCE(
        JSON_VALUE(TO_JSON_STRING(custom_metrics.other.almanac), '$.videos.total_with_track'),
        JSON_VALUE(TO_JSON_STRING(custom_metrics.markup),        '$.videos.total_with_track'),
        JSON_EXTRACT_SCALAR(payload,                             '$._almanac.videos.total_with_track') -- legacy fallback; remove if 2025-only
      ) AS INT64
    ) AS total_with_track
  FROM `httparchive.crawl.pages`
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)  -- enable for cheap tests only
  WHERE date = DATE '2025-07-01'
)

SELECT
  client,
  is_root_page,
  COUNT(*) AS total_sites,
  COUNTIF(total_videos > 0)     AS total_with_video,
  COUNTIF(total_with_track > 0) AS total_with_tracks,

  -- formatted percentages
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(SUM(total_with_track), NULLIF(SUM(total_videos), 0)))          AS pct_videos_with_tracks,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(total_videos > 0), COUNT(*)))                          AS pct_sites_with_videos,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(total_with_track > 0), NULLIF(COUNTIF(total_videos > 0), 0))) AS pct_video_sites_with_tracks

FROM base
GROUP BY client, is_root_page
ORDER BY client, is_root_page;
