WITH video_data AS (
  SELECT
    client,
    LOWER(COALESCE(JSON_VALUE(video_nodes.autoplay), '(autoplay not used)')) AS autoplay_value
  FROM
    `httparchive.crawl.pages`,
    UNNEST(JSON_EXTRACT_ARRAY(custom_metrics.other.almanac.videos.nodes)) AS video_nodes
  WHERE
    date = '2025-07-01' AND
    is_root_page
  ORDER BY
    client,
    page
)

SELECT
  client,
  IF(autoplay_value = '', '(empty)', autoplay_value) AS autoplay_value,
  COUNT(0) AS autoplay_value_count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_videos,
  ROUND(
    SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) * 100, 2
  ) AS autoplay_value_pct
FROM
  video_data
GROUP BY
  client,
  autoplay_value
QUALIFY
  autoplay_value_count > 10
ORDER BY
  client ASC,
  autoplay_value_count DESC;
