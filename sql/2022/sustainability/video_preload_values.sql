#standardSQL
# preload attribute values

SELECT
  client,
  IF(preload_value = '', '(empty)', preload_value) AS preload_value,
  COUNT(0) AS preload_value_count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_videos,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS preload_value_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    LOWER(IFNULL(JSON_EXTRACT_SCALAR(video_nodes, '$.preload'), '(preload not used)')) AS preload_value
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.nodes')) AS video_nodes
)
GROUP BY
  client,
  preload_value
QUALIFY
  preload_value_count > 10
ORDER BY
  client,
  preload_value_count DESC;
