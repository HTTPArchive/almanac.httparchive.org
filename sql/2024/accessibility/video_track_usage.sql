#standardSQL
# Video elements track usage

SELECT
  client,
  is_root_page,
  COUNT(0) AS total_sites,
  COUNTIF(total_videos > 0) AS total_with_video,
  COUNTIF(total_with_track > 0) AS total_with_tracks,

  SUM(total_with_track) / SUM(total_videos) AS pct_videos_with_tracks,
  COUNTIF(total_videos > 0) / COUNT(0) AS pct_sites_with_videos,
  COUNTIF(total_with_track > 0) / COUNTIF(total_videos > 0) AS pct_video_sites_with_tracks
FROM (
  SELECT
    client,
    is_root_page,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.total') AS INT64) AS total_videos,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.total_with_track') AS INT64) AS total_with_track
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client,
  is_root_page;
