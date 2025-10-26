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
    CAST(JSON_VALUE(custom_metrics.other.almanac.videos.total) AS INT64) AS total_videos,
    CAST(JSON_VALUE(custom_metrics.other.almanac.videos.total_with_track) AS INT64) AS total_with_track
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)
GROUP BY
  client,
  is_root_page;
