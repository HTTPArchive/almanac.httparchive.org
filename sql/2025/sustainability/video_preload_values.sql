WITH video_data AS (
  SELECT
    date,
    client,
    LOWER(
      COALESCE(
        JSON_EXTRACT_SCALAR(video_nodes, '$.preload'),
        '(preload not used)'
      )
    ) AS preload_value
  FROM
    `httparchive.crawl.pages`,
    UNNEST(
      JSON_EXTRACT_ARRAY(
        JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.nodes'
      )
    ) AS video_nodes
  WHERE
    date IN ('2025-06-01', '2024-07-01') AND  -- Updated dates
    is_root_page
)

SELECT
  date,
  client,
  IF(preload_value = '', '(empty)', preload_value) AS preload_value,
  COUNT(0) AS preload_value_count,
  SAFE_DIVIDE(
    COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY date, client)
  ) AS preload_value_pct
FROM
  video_data
GROUP BY
  date,
  client,
  preload_value
QUALIFY
  preload_value_count > 10
ORDER BY
  date ASC,
  client ASC,
  preload_value_count DESC
