#standardSQL
# Video elements track usage
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(total_videos > 0) AS total_with_video,
  COUNTIF(total_tracks > 0) AS total_with_tracks,

  COUNTIF(total_videos > 0) / COUNT(0) AS pct_sites_with_videos,
  COUNTIF(total_tracks > 0) / COUNTIF(total_videos > 0) AS pct_sites_with_tracks
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.total') AS INT64) AS total_videos,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.tracks.total') AS INT64) AS total_tracks
  FROM
    `httparchive.pages.2020_08_01_*`
)
GROUP BY
  client
