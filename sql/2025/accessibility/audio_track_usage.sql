-- standardSQL
-- Web Almanac — Audio elements with <track> usage (2025)
-- Google Sheet: audio_track_usage
--
-- This query:
--   • Uses `httparchive.crawl.pages` at the site level (client × is_root_page).
--   • Extracts <audio> counts and <audio><track> counts from the _almanac JSON payload.
--   • Counts sites with any audio and sites with audio tracks.
--   • Computes percentages:
--       - pct_audios_with_tracks      = SUM(total_with_track) / SUM(total_audios)
--       - pct_sites_with_audios       = sites_with_audio / total_sites
--       - pct_audio_sites_with_tracks = sites_with_tracks / sites_with_audio
--   • Groups results by client (desktop/mobile) and is_root_page (TRUE/FALSE).
SELECT
  client,
  is_root_page,
  COUNT(0) AS total_sites,
  COUNTIF(total_audios > 0) AS total_with_audio,
  COUNTIF(total_with_track > 0) AS total_with_tracks,

  SUM(total_with_track) / SUM(total_audios) AS pct_audios_with_tracks,
  COUNTIF(total_audios > 0) / COUNT(0) AS pct_sites_with_audios,
  COUNTIF(total_with_track > 0) / COUNTIF(total_audios > 0) AS pct_audio_sites_with_tracks
FROM (
  SELECT
    client,
    is_root_page,
    date,
    -- CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.audios.total') AS INT64) AS total_audios,
    -- CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.audios.total_with_track') AS INT64) AS total_with_track
    CAST(JSON_VALUE(custom_metrics.other.almanac.audios.total) AS INT64) AS total_audios,
    CAST(JSON_VALUE(custom_metrics.other.almanac.audios.total_with_track) AS INT64) AS total_with_track
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)
GROUP BY
  client,
  is_root_page;
