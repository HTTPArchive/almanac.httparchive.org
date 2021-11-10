#standardSQL

WITH videonotes AS (

  SELECT
    url AS pageURL,
    JSON_VALUE(payload, "$._media") AS media,
    CAST(JSON_VALUE(JSON_VALUE(payload, "$._media"), "$.num_video_nodes") AS INT64) AS num_video_nodes,
    (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_durations")) AS video_duration,
    (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_display_style")) AS video_display_style,
    ARRAY_TO_STRING(JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_attributes_values_counts"), " ") AS video_attributes_values_counts,
    (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_source_format_count")) AS video_source_format_count,
    (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_source_format_type")) AS video_source_format_type
  FROM
    `httparchive.pages.2021_07_01_desktop`
),

video_attributes AS (
  SELECT
    pageURL,
    JSON_VALUE(video_attributes_values_counts, "$.attribute") AS attribute,
    JSON_VALUE(video_attributes_values_counts, "$.value") AS value,
    cast(JSON_VALUE(video_attributes_values_counts, "$.count") AS int64) AS cnt,
    video_attributes_values_counts
  FROM
    videonotes
  WHERE
    num_video_nodes > 0
)

SELECT
  attribute,
  value,
  SUM(cnt) AS freq
FROM
  video_attributes
GROUP BY
  attribute,
  value
ORDER BY
  attribute ASC
