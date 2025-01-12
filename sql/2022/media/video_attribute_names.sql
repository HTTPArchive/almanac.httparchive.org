#standardSQL
# What attribute *names* are common?

WITH videonotes AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS pageURL,
    JSON_VALUE(payload, '$._media') AS media,
    CAST(JSON_VALUE(JSON_VALUE(payload, '$._media'), '$.num_video_nodes') AS INT64) AS num_video_nodes, (JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_durations')) AS video_duration, (JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_display_style')) AS video_display_style,
    ARRAY_TO_STRING(JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_attributes_values_counts'), ' ') AS video_attributes_values_counts, (JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_source_format_count')) AS video_source_format_count, (JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._media'), '$.video_source_format_type')) AS video_source_format_type
  FROM
    `httparchive.pages.2022_06_01_*`
),

video_attributes AS (
  SELECT
    client,
    pageURL,
    JSON_VALUE(video_attributes_values_counts, '$.attribute') AS attribute,
    JSON_VALUE(video_attributes_values_counts, '$.value') AS value,
    CAST(JSON_VALUE(video_attributes_values_counts, '$.count') AS INT64) AS cnt,
    video_attributes_values_counts
  FROM
    videonotes
  WHERE
    num_video_nodes > 0
)

SELECT
  client,
  attribute,
  SUM(cnt) AS freq,
  SUM(SUM(cnt)) OVER (PARTITION BY client) AS total,
  SUM(cnt) / SUM(SUM(cnt)) OVER (PARTITION BY client) AS pct
FROM
  video_attributes
GROUP BY
  client,
  attribute
ORDER BY
  pct DESC
