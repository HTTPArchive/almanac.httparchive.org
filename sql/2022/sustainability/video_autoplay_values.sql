#standardSQL
# autoplay attribute values

SELECT
  client,
  IF(autoplay_value = '', '(empty)', autoplay_value) AS autoplay_value,
  COUNT(0) AS autoplay_value_count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_videos,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS autoplay_value_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    LOWER(IFNULL(JSON_EXTRACT_SCALAR(video_nodes, '$.autoplay'), '(autoplay not used)')) AS autoplay_value
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.nodes')) AS video_nodes
)
GROUP BY
  client,
  autoplay_value
QUALIFY
  autoplay_value_count > 10
ORDER BY
  client,
  autoplay_value_count DESC;
