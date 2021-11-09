#standardSQL
# Audio elements track usage
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(total_audios > 0) AS total_with_audio,
  COUNTIF(total_with_track > 0) AS total_with_tracks,

  SUM(total_with_track) / SUM(total_audios) AS pct_audios_with_tracks,
  COUNTIF(total_audios > 0) / COUNT(0) AS pct_sites_with_audios,
  COUNTIF(total_with_track > 0) / COUNTIF(total_audios > 0) AS pct_audio_sites_with_tracks
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.audios.total') AS INT64) AS total_audios,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.audios.total_with_track') AS INT64) AS total_with_track
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
