WITH video_data AS (
  SELECT
    date,
    client,
    LOWER(IFNULL(JSON_EXTRACT_SCALAR(video_nodes, '$.preload'), '(preload not used)')) AS preload_value
  FROM
    `httparchive.all.pages`,
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.nodes')) AS video_nodes
  WHERE
    date IN ('2024-06-01', '2023-07-01')  -- Updated dates
    AND is_root_page
)

SELECT
  date,
  client,
  IF(preload_value = '', '(empty)', preload_value) AS preload_value,
  COUNT(0) AS preload_value_count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY date, client)) AS preload_value_pct
FROM
  video_data
GROUP BY
  date,
  client,
  preload_value
QUALIFY
  preload_value_count > 10
ORDER BY
  date,
  client,
  preload_value_count DESC
