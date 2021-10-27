#standardSQL

WITH videonotes AS (
  SELECT
    pageURL,
    num_video_nodes,
    video_source_format_type,
    source_formats,
    video_source_format_type,
    source_format_count
  FROM (
<<<<<<< HEAD
      SELECT
        url AS pageURL,
        JSON_VALUE(payload, "$._media") AS media,
        CAST(JSON_VALUE(JSON_VALUE(payload, "$._media"), "$.num_video_nodes") AS INT64) AS num_video_nodes,
        (JSON_QUERY(JSON_VALUE(payload, "$._media"), "$.video_durations")) AS video_duration,
        (JSON_QUERY(JSON_VALUE(payload, "$._media"), "$.video_display_style")) AS video_display_style,
        (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_attributes_values_counts")) AS video_attributes_values_counts,
        (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_source_format_count")) AS video_source_format_count,
        (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_source_format_type")) AS video_source_format_type
      FROM
        `httparchive.summary_pages.2021_07_01_desktop`
    )
  CROSS JOIN
    UNNEST(video_source_format_type) AS source_formats
  CROSS JOIN
    UNNEST(video_source_format_count) AS source_format_count
||||||| parent of fd5fb93b... fixed table, added a few more
        SELECT
            url as pageURL,
            JSON_VALUE( payload, "$._media" ) as media,
            CAST( JSON_VALUE(JSON_VALUE( payload, "$._media" ),"$.num_video_nodes") AS INT64) as num_video_nodes,
            ( JSON_QUERY(JSON_VALUE( payload, "$._media" ),"$.video_durations")  ) as video_duration,
            ( JSON_QUERY(JSON_VALUE( payload, "$._media" ),"$.video_display_style")) as video_display_style,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_attributes_values_counts") ) as video_attributes_values_counts,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_count") ) as video_source_format_count,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_type") ) as video_source_format_type,
        FROM `httparchive.summary_pages.2021_07_01_desktop`
        ) 
    CROSS JOIN UNNEST(video_source_format_type) AS source_formats
    CROSS JOIN UNNEST(video_source_format_count) AS source_format_count
=======
        SELECT
            url as pageURL,
            JSON_VALUE( payload, "$._media" ) as media,
            CAST( JSON_VALUE(JSON_VALUE( payload, "$._media" ),"$.num_video_nodes") AS INT64) as num_video_nodes,
            ( JSON_QUERY(JSON_VALUE( payload, "$._media" ),"$.video_durations")  ) as video_duration,
            ( JSON_QUERY(JSON_VALUE( payload, "$._media" ),"$.video_display_style")) as video_display_style,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_attributes_values_counts") ) as video_attributes_values_counts,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_count") ) as video_source_format_count,
            ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_type") ) as video_source_format_type,
        FROM `httparchive.pages.2021_07_01_desktop`
        ) 
    CROSS JOIN UNNEST(video_source_format_type) AS source_formats
    CROSS JOIN UNNEST(video_source_format_count) AS source_format_count
>>>>>>> fd5fb93b... fixed table, added a few more
)

<<<<<<< HEAD
SELECT
  source_formats,
  COUNT(source_formats) AS numberofoccurances
FROM
  videonotes
WHERE
  num_video_nodes > 0
GROUP BY
  source_formats
ORDER BY
  numberofoccurances DESC
||||||| parent of fd5fb93b... fixed table, added a few more

SELECT  source_formats,count(source_formats) as numberofoccurances
from videonotes
WHERE num_video_nodes>0
group by  source_formats
order by numberofoccurances desc
=======

SELECT  source_formats,source_format_count,count(source_formats) as numberofoccurances
from videonotes
WHERE num_video_nodes>0
group by  source_formats, source_format_count
order by numberofoccurances desc
>>>>>>> fd5fb93b... fixed table, added a few more
