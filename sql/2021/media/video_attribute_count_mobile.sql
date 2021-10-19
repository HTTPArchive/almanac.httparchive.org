WITH video_attributes AS(

WITH videonotes AS (
SELECT
    url as pageURL,
    JSON_VALUE( payload, "$._media" ) as media,
    CAST( JSON_VALUE(JSON_VALUE( payload, "$._media" ),"$.num_video_nodes") AS INT64) as num_video_nodes,
     ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_durations")  ) as video_duration,
    ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_display_style")) as video_display_style,
    ARRAY_TO_STRING( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_attributes_values_counts")," ") as video_attributes_values_counts,
    ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_count") ) as video_source_format_count,
    ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_type") ) as video_source_format_type,
FROM `httparchive.summary_pages.2021_07_01_mobile`
) 


SELECT pageURL,
        JSON_VALUE(video_attributes_values_counts, "$.attribute") as attribute,
        JSON_VALUE(video_attributes_values_counts, "$.value") as value,
       cast( JSON_VALUE(video_attributes_values_counts, "$.count") as int64) as cnt,
       video_attributes_values_counts
    FROM videonotes
where num_video_nodes >0

)

Select attribute, value, sum(cnt)
from video_attributes
group by attribute, value
order by attribute asc