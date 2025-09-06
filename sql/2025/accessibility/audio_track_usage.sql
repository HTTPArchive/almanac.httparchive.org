-- standardSQL
-- Web Almanac — Audio elements with <track> usage (2025)
--
-- What this query does
--   For each (client, is_root_page), at the SITE (hostname) level:
--     • Count sites that have any <audio>
--     • Count sites that have <audio> with <track>
--     • Compute:
--         - pct_audios_with_tracks      = SUM(tracks) / SUM(audios)
--         - pct_sites_with_audios       = sites_with_audios / total_sites
--         - pct_audio_sites_with_tracks = sites_with_tracks / sites_with_audios
--
-- Key choices
--   • Unit = site (NET.HOST of a canonical-ish URL), mirroring 2024.
--   • Keep root/non-root split as separate rows.
--   • Robust JSON paths for 2025:
--       - Primary (2025):   custom_metrics.other.almanac.audios.total / .total_with_track
--       - Also try (2025):  custom_metrics.markup.audios.total / .total_with_track
--       - Legacy fallback:  payload._almanac.audios.total / .total_with_track
--     NOTE: We reference JSON fields *inside* the custom_metrics struct, e.g. custom_metrics.other
--   • URL for host:
--       - custom_metrics.performance.lcp_resource.documentURL
--       - OR payload.url / payload._url
--   • Use SAFE_DIVIDE to avoid division-by-zero.
--
-- Output columns
--   client, is_root_page, total_sites, sites_with_audios, sites_with_tracks,
--   pct_audios_with_tracks, pct_sites_with_audios, pct_audio_sites_with_tracks
--
WITH per_page AS (
  SELECT
    client,
    is_root_page,

    -- Canonical-ish URL to derive hostname
    COALESCE(
      JSON_VALUE(custom_metrics.performance, '$.lcp_resource.documentURL'),
      JSON_VALUE(payload, '$.url'),
      JSON_VALUE(payload, '$._url')
    ) AS url_str,

    -- <audio> totals (modern paths first, then legacy)
    COALESCE(
      SAFE_CAST(JSON_VALUE(custom_metrics.other,  '$.almanac.audios.total') AS INT64),
      SAFE_CAST(JSON_VALUE(custom_metrics.markup, '$.audios.total') AS INT64),
      SAFE_CAST(JSON_VALUE(payload,                '$._almanac.audios.total') AS INT64),
      0
    ) AS total_audios,

    -- <track> inside <audio> (modern paths first, then legacy)
    COALESCE(
      SAFE_CAST(JSON_VALUE(custom_metrics.other,  '$.almanac.audios.total_with_track') AS INT64),
      SAFE_CAST(JSON_VALUE(custom_metrics.markup, '$.audios.total_with_track') AS INT64),
      SAFE_CAST(JSON_VALUE(payload,                '$._almanac.audios.total_with_track') AS INT64),
      0
    ) AS total_with_track
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
),
per_site AS (
  -- Collapse pages into sites within (client, is_root_page)
  SELECT
    client,
    is_root_page,
    NET.HOST(url_str) AS host,
    SUM(total_audios)       AS sum_audios,
    SUM(total_with_track)   AS sum_with_track,
    LOGICAL_OR(total_audios > 0)      AS has_audio,
    LOGICAL_OR(total_with_track > 0)  AS has_track
  FROM per_page
  WHERE url_str IS NOT NULL
    AND (STARTS_WITH(url_str, 'http://') OR STARTS_WITH(url_str, 'https://'))
  GROUP BY client, is_root_page, host
)
SELECT
  client,
  is_root_page,
  COUNT(*)                        AS total_sites,
  COUNTIF(has_audio)              AS sites_with_audios,
  COUNTIF(has_track)              AS sites_with_tracks,
  SAFE_DIVIDE(SUM(sum_with_track), SUM(sum_audios))   AS pct_audios_with_tracks,
  SAFE_DIVIDE(COUNTIF(has_audio), COUNT(*))           AS pct_sites_with_audios,
  SAFE_DIVIDE(COUNTIF(has_track), COUNTIF(has_audio)) AS pct_audio_sites_with_tracks
FROM per_site
GROUP BY client, is_root_page
ORDER BY client, is_root_page DESC;
