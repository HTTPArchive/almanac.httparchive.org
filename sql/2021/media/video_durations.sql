#standardSQL

WITH videonotes AS (
  SELECT
    client,
    pageURL,
    CAST(durations AS FLOAT64) AS durations,
    CASE
      WHEN CAST(durations AS FLOAT64) <= 1 THEN "under1"
      WHEN (CAST(durations AS FLOAT64) > 1 AND CAST(durations AS FLOAT64) <= 5) THEN "under5"
      WHEN (CAST(durations AS FLOAT64) > 5 AND CAST(durations AS FLOAT64) <= 10) THEN "under10"
      WHEN (CAST(durations AS FLOAT64) > 10 AND CAST(durations AS FLOAT64) <= 20) THEN "under20"
      WHEN (CAST(durations AS FLOAT64) > 20 AND CAST(durations AS FLOAT64) <= 30) THEN "under30"
      WHEN (CAST(durations AS FLOAT64) > 30 AND CAST(durations AS FLOAT64) <= 45) THEN "under45"
      WHEN (CAST(durations AS FLOAT64) > 45 AND CAST(durations AS FLOAT64) <= 60) THEN "under60"
      WHEN (CAST(durations AS FLOAT64) > 60 AND CAST(durations AS FLOAT64) <= 90) THEN "under90"
      WHEN (CAST(durations AS FLOAT64) > 90 AND CAST(durations AS FLOAT64) <= 120) THEN "under120"
      WHEN (CAST(durations AS FLOAT64) > 120 AND CAST(durations AS FLOAT64) <= 180) THEN "under180"
      WHEN (CAST(durations AS FLOAT64) > 180 AND CAST(durations AS FLOAT64) <= 300) THEN "under300"
      WHEN (CAST(durations AS FLOAT64) > 300 AND CAST(durations AS FLOAT64) <= 600) THEN "under600"
      ELSE "over600"
    END AS duration_bucket
  FROM (
      SELECT
        _TABLE_SUFFIX AS client,
        url AS pageURL,
        JSON_VALUE(payload, "$._media") AS media,
        CAST(JSON_VALUE(JSON_VALUE(payload, "$._media"), "$.num_video_nodes") AS INT64) AS num_video_nodes,
        (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_durations")) AS video_duration,
        (JSON_QUERY(JSON_VALUE(payload, "$._media"), "$.video_display_style")) AS video_display_style,
        (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_attributes_values_counts")) AS video_attributes_values_counts,
        (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_source_format_count")) AS video_source_format_count,
        (JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._media"), "$.video_source_format_type")) AS video_source_format_type
      FROM
        `httparchive.pages.2021_07_01_*`
    )
  CROSS JOIN
    UNNEST(video_duration) AS durations
  WHERE
    num_video_nodes > 0 AND
    durations != "null"
  ORDER BY
    durations DESC
)

SELECT
  client,
  duration_bucket,
  COUNT(duration_bucket) AS freq,
  COUNT(duration_bucket) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  videonotes
GROUP BY
  client,
  duration_bucket
ORDER BY
  freq DESC
