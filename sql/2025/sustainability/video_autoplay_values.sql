WITH video_data AS (
  SELECT
    client,
    LOWER(
      COALESCE(
        JSON_EXTRACT_SCALAR(video_nodes, '$.autoplay'),
        '(autoplay not used)'
      )
    ) AS autoplay_value
  FROM
    `httparchive.crawl.pages`,
    UNNEST(
      JSON_EXTRACT_ARRAY(
        JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.nodes'
      )
    ) AS video_nodes
  WHERE
    date = '2025-06-01' AND  -- Updated date
    is_root_page
  LIMIT 10000  -- Limit the number of rows processed for faster testing
)

SELECT
  client,
  IF(autoplay_value = '', '(empty)', autoplay_value) AS autoplay_value,
  COUNT(1) AS autoplay_value_count,
  SUM(COUNT(1)) OVER (PARTITION BY client) AS total_videos,
  ROUND(
    SAFE_DIVIDE(COUNT(1), SUM(COUNT(1)) OVER (PARTITION BY client)) * 100, 2
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
  autoplay_value_count DESC
