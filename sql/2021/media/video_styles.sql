#standardSQL

WITH videonotes AS (
  SELECT
    client,
    pageURL,
    num_video_nodes,
    styles
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      url AS pageURL,
      JSON_VALUE(payload, '$._media') AS media,
      CAST(JSON_VALUE(JSON_VALUE(payload, '$._media'), '$.num_video_nodes') AS INT64) AS num_video_nodes,
      JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_durations') AS video_duration,
      JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_display_style') AS video_display_style,
      JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_attributes_values_counts') AS video_attributes_values_counts,
      JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_source_format_count') AS video_source_format_count,
      JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_source_format_type') AS video_source_format_type
    FROM
      `httparchive.pages.2021_07_01_*`
  )
  CROSS JOIN
    UNNEST(video_display_style) AS styles
),

total_videos AS (
  SELECT
    client,
    COUNT(DISTINCT pageURL) AS urls,
    SUM(num_video_nodes) AS total_video_nodes
  FROM
    videonotes
  GROUP BY
    client
)

SELECT
  client,
  styles,
  COUNT(styles) AS freq,
  COUNT(styles) / total_video_nodes AS videos_pct
FROM
  videonotes
JOIN
  total_videos
USING (client)
WHERE
  num_video_nodes > 0
GROUP BY
  client,
  styles,
  total_video_nodes
ORDER BY
  freq DESC,
  styles ASC
