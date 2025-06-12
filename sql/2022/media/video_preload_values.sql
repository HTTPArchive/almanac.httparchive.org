#standardSQL
# preload attribute values

SELECT
  date,
  client,
  IF(preload_value = '', '(empty)', preload_value) AS preload_value,
  COUNT(0) AS preload_value_count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY date, client)) AS preload_value_pct
FROM (
  SELECT
    '2022-06-01' AS date,
    _TABLE_SUFFIX AS client,
    LOWER(IFNULL(JSON_EXTRACT_SCALAR(video_nodes, '$.preload'), '(preload not used)')) AS preload_value
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.nodes')) AS video_nodes
  UNION ALL
  SELECT
    '2021-07-01' AS date,
    _TABLE_SUFFIX AS client,
    LOWER(IFNULL(JSON_EXTRACT_SCALAR(video_nodes, '$.preload'), '(preload not used)')) AS preload_value
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.nodes')) AS video_nodes
)
GROUP BY
  date,
  client,
  preload_value
QUALIFY
  preload_value_count > 10
ORDER BY
  date,
  client,
  preload_value_count DESC;
