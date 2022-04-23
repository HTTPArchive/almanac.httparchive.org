SELECT
  client,
  COUNTIF(num_video_nodes > 0) AS pages,
  COUNT(0) AS total,
  COUNTIF(num_video_nodes > 0) / COUNT(0) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_VALUE(JSON_VALUE(payload, '$._media'), '$.num_video_nodes') AS INT64) AS num_video_nodes
  FROM
    `httparchive.pages.2021_07_01_*`)
GROUP BY
  client
