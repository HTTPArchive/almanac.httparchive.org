#standardSQL
# preload attribute values

SELECT
  percentile,
  client,
  IF(preload_value = '', '(empty)', preload_value) AS preload_value,
  COUNT(0) AS preload_value_count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY percentile, client)) AS preload_value_pct
FROM
  (
    SELECT
      percentile,
      _TABLE_SUFFIX AS client,
      LOWER(IFNULL(JSON_EXTRACT_SCALAR(video_nodes, '$.preload'), '(preload not used)')) AS preload_value
    FROM
      `httparchive.pages.2022_06_01_*`,
      UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.nodes')) AS video_nodes,
      UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  )
GROUP BY
  percentile,
  client,
  preload_value
QUALIFY
  preload_value_count > 10
ORDER BY
  percentile,
  client,
  preload_value_count DESC;
