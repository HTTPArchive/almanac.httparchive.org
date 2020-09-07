#standardSQL
# 08_26: How often sites with video elements use tracks
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(total_videos > 0) AS total_with_video,
  COUNTIF(total_tracks > 0) AS total_with_tracks,

  ROUND(COUNTIF(total_videos > 0) * 100 / COUNT(0), 2) AS pct_sites_with_videos,
  ROUND(COUNTIF(total_tracks > 0) * 100 / COUNTIF(total_videos > 0), 2) AS pct_sites_with_tracks
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, "$._almanac"), "$.videos.total") AS INT64) AS total_videos,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, "$._almanac"), "$.videos.tracks.total") AS INT64) AS total_tracks
  FROM
    `httparchive.almanac.pages_desktop_*`
)
GROUP BY
  client
