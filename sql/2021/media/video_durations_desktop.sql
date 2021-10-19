WITH videonotes AS (
    SELECT
    pageURL,
    CAST(durations as FLOAT64) as durations,
    CASE 
        WHEN CAST(durations as FLOAT64) <=1 THEN  "under1"
        WHEN (CAST(durations as FLOAT64) >1 AND CAST(durations as FLOAT64) <=5)  THEN  "under5"
        WHEN (CAST(durations as FLOAT64) >5 AND CAST(durations as FLOAT64) <=10)  THEN  "under10"
        WHEN (CAST(durations as FLOAT64) >10 AND CAST(durations as FLOAT64) <=20)  THEN  "under20"
        WHEN (CAST(durations as FLOAT64) >20 AND CAST(durations as FLOAT64) <=30)  THEN  "under30"
        WHEN (CAST(durations as FLOAT64) >30 AND CAST(durations as FLOAT64) <=45)  THEN  "under45"
        WHEN (CAST(durations as FLOAT64) >45 AND CAST(durations as FLOAT64) <=60)  THEN  "under60"
        WHEN (CAST(durations as FLOAT64) >60 AND CAST(durations as FLOAT64) <=90)  THEN  "under90"
        WHEN (CAST(durations as FLOAT64) >90 AND CAST(durations as FLOAT64) <=120)  THEN  "under120"
        WHEN (CAST(durations as FLOAT64) >120 AND CAST(durations as FLOAT64) <=180)  THEN  "under180"
        WHEN (CAST(durations as FLOAT64) >180 AND CAST(durations as FLOAT64) <=300)  THEN  "under300"
        WHEN (CAST(durations as FLOAT64) >300 AND CAST(durations as FLOAT64) <=600)  THEN  "under600"
        else "over600"
        END as duration_bucket
  FROM (
        SELECT
            url as pageURL,
            JSON_VALUE( payload, "$._media" ) as media,
            CAST( JSON_VALUE(JSON_VALUE( payload, "$._media" ),"$.num_video_nodes") AS INT64) as num_video_nodes,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_durations")  ) as video_duration,
            ( JSON_QUERY(JSON_VALUE( payload, "$._media" ),"$.video_display_style")) as video_display_style,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_attributes_values_counts") ) as video_attributes_values_counts,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_count") ) as video_source_format_count,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_type") ) as video_source_format_type,
        FROM `httparchive.summary_pages.2021_07_01_desktop`
        ) 
        CROSS JOIN UNNEST(video_duration) AS durations
     WHERE   num_video_nodes>0 AND durations != "null"
    ORDER BY durations desc
   )

SELECT  duration_bucket, count(duration_bucket)
from videonotes
group by duration_bucket
order by duration_bucket asc
