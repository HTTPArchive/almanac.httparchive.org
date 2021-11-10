SELECT
  count(pageURL)
FROM (
  SELECT
    url AS pageURL,
    JSON_VALUE( payload, "$._media" ) AS media,
    CAST( JSON_VALUE(JSON_VALUE(payload, "$._media"), "$.num_video_nodes") AS INT64) AS num_video_nodes,
    ( JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_durations")) AS video_duration,
    ( JSON_QUERY(JSON_VALUE(payload, "$._media"), "$.video_display_style")) AS video_display_style,
    ( JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_attributes_values_counts")) AS video_attributes_values_counts,
    ( JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_source_format_count")) AS video_source_format_count,
    ( JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_source_format_type")) AS video_source_format_type
  FROM `httparchive.pages.2021_07_01_desktop`
)
WHERE
  num_video_nodes > 0
