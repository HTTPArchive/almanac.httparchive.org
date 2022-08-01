#standardSQL
# autoplay attribute values

SELECT
  percentile,
  client,
  IF(autoplay_value = '', '(empty)', autoplay_value) AS autoplay_value,
  COUNT(0) AS autoplay_value_count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY percentile, client)) AS autoplay_value_pct
FROM
  (
    SELECT
      percentile,
      _TABLE_SUFFIX AS client,
      LOWER(IFNULL(JSON_EXTRACT_SCALAR(video_nodes, '$.autoplay'), '(autoplay not used)')) AS autoplay_value
    FROM
      `httparchive.sample_data.pages_*`,
      UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.videos.nodes')) AS video_nodes,
      UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  )
GROUP BY
  percentile,
  client,
  autoplay_value
QUALIFY
  autoplay_value_count > 10
ORDER BY
  percentile,
  client,
  autoplay_value_count DESC;
