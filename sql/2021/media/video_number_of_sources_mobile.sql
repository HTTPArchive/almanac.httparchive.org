WITH videonotes AS (
    SELECT
    pageURL,
    num_video_nodes,
    video_source_format_count,
    source_count, 
    video_source_format_type
  FROM (
        SELECT
            url as pageURL,
            JSON_VALUE( payload, "$._media" ) as media,
            CAST( JSON_VALUE(JSON_VALUE( payload, "$._media" ),"$.num_video_nodes") AS INT64) as num_video_nodes,
            ( JSON_QUERY(JSON_VALUE( payload, "$._media" ),"$.video_durations")  ) as video_duration,
            ( JSON_QUERY(JSON_VALUE( payload, "$._media" ),"$.video_display_style")) as video_display_style,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_attributes_values_counts") ) as video_attributes_values_counts,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_count") ) as video_source_format_count,
            ( JSON_QUERY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_type") ) as video_source_format_type,
        FROM `httparchive.summary_pages.2021_07_01_mobile`
        ) 
    CROSS JOIN UNNEST(video_source_format_count) AS source_count
)


SELECT  cast(source_count as int64) as source_counter, count(cast(source_count as int64)) as numberofoccurances
from videonotes
WHERE num_video_nodes>0
group by  source_count
order by source_counter desc
