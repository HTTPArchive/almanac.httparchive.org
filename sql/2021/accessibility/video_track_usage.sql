#standardSQL
# Video elements track usage
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(total_videos > 0) AS total_with_video,
  COUNTIF(total_with_track > 0) AS total_with_tracks,

  SUM(total_with_track) / SUM(total_videos) AS pct_videos_with_tracks,
  COUNTIF(total_videos > 0) / COUNT(0) AS pct_sites_with_videos,
  COUNTIF(total_with_track > 0) / COUNT(0) AS pct_sites_with_videos_with_tracks
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.total') AS INT64) AS total_videos,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.total_with_track') AS INT64) AS total_with_track
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
