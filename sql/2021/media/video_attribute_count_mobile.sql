#standardSQL

WITH videonotes AS (
<<<<<<< HEAD
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
    `httparchive.pages.2021_07_01_mobile`
),
||||||| parent of fd5fb93b... fixed table, added a few more
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
=======
SELECT
    url as pageURL,
    JSON_VALUE( payload, "$._media" ) as media,
    CAST( JSON_VALUE(JSON_VALUE( payload, "$._media" ),"$.num_video_nodes") AS INT64) as num_video_nodes,
     ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_durations")  ) as video_duration,
    ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_display_style")) as video_display_style,
    ARRAY_TO_STRING( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_attributes_values_counts")," ") as video_attributes_values_counts,
    ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_count") ) as video_source_format_count,
    ( JSON_QUERY_ARRAY(JSON_VALUE( payload, "$._media" ),"$.video_source_format_type") ) as video_source_format_type,
FROM `httparchive.pages.2021_07_01_mobile`
) 


SELECT pageURL,
        JSON_VALUE(video_attributes_values_counts, "$.attribute") as attribute,
        JSON_VALUE(video_attributes_values_counts, "$.value") as value,
       cast( JSON_VALUE(video_attributes_values_counts, "$.count") as int64) as cnt,
       video_attributes_values_counts
    FROM videonotes
where num_video_nodes >0
>>>>>>> fd5fb93b... fixed table, added a few more

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

<<<<<<< HEAD
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
||||||| parent of fd5fb93b... fixed table, added a few more
Select attribute, value, sum(cnt)
from video_attributes
group by attribute, value
order by attribute asc
=======
Select attribute, value, sum(cnt) as num
from video_attributes
group by attribute, value
order by attribute asc, num desc
>>>>>>> fd5fb93b... fixed table, added a few more
