#standardSQL
# How many pages use <video>?

SELECT
  SUBSTR(_TABLE_SUFFIX, 0, 10) AS date,
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  COUNTIF(num_video_nodes > 0) AS pages,
  COUNT(0) AS total,
  COUNTIF(num_video_nodes > 0) / COUNT(0) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_VALUE(JSON_VALUE(payload, '$._media'), '$.num_video_nodes') AS INT64) AS num_video_nodes
  FROM
    `httparchive.pages.*`
  WHERE
    _TABLE_SUFFIX >= '2020-08-01'
)
GROUP BY
  date,
  client
ORDER BY
  date DESC,
  client
