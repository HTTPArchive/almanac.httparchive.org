#standardSQL

WITH videonotes AS (
  SELECT
    client,
    pageURL,
    num_video_nodes,
    video_source_format_count,
    source_count,
    video_source_format_type
  FROM (

    SELECT
      _TABLE_SUFFIX AS client,
      url AS pageURL,
      JSON_VALUE(payload, '$._media') AS media,
      CAST(JSON_VALUE(JSON_VALUE(payload, '$._media'), '$.num_video_nodes') AS INT64) AS num_video_nodes, (JSON_QUERY(JSON_VALUE(payload, '$._media'), '$.video_durations')) AS video_duration, (JSON_QUERY(JSON_VALUE(payload, '$._media'), '$.video_display_style')) AS video_display_style, (JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_attributes_values_counts')) AS video_attributes_values_counts, (JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_source_format_count')) AS video_source_format_count, (JSON_QUERY(JSON_VALUE(payload, '$._media'), '$.video_source_format_type')) AS video_source_format_type
    FROM
      `httparchive.pages.2021_07_01_*`
  )
  CROSS JOIN
    UNNEST(video_source_format_count) AS source_count

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
  CAST(source_count AS INT64) AS source_counter,
  COUNT(CAST(source_count AS INT64)) AS numberofoccurances,
  COUNT(CAST(source_count AS INT64)) / total_video_nodes AS pct_numberofoccurances_per_video
FROM
  videonotes
JOIN
  total_videos
USING (client)
WHERE
  num_video_nodes > 0
GROUP BY
  client,
  source_count,
  total_video_nodes
ORDER BY
  numberofoccurances DESC,
  source_counter DESC
