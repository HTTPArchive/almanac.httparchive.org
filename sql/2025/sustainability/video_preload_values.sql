WITH video_data AS (
  SELECT
    client,
    LOWER(COALESCE(JSON_VALUE(video_nodes.preload), '(preload not used)')) AS preload_value
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
  IF(preload_value = '', '(empty)', preload_value) AS preload_value,
  COUNT(0) AS preload_value_count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_videos,
  ROUND(
    SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) * 100, 2
  ) AS preload_value_pct
FROM
  video_data
GROUP BY
  client,
  preload_value
QUALIFY
  preload_value_count > 10
ORDER BY
  client ASC,
  preload_value_count DESC;
