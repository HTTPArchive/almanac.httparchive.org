#standardSQL
# How many videos are autoplay/muted

# returns all the data we need from _media
CREATE TEMPORARY FUNCTION get_media_info(media_string STRING)
RETURNS STRUCT<
  num_video_nodes INT64,
  video_nodes_attributes ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};
try {
    var media = JSON.parse(media_string);
    var attributes = Array();
    if(Array.isArray(media.video_attributes_values_counts)) {
      media.video_attributes_values_counts.map(({attribute}) => {
        attributes.push(attribute)
      })
    }
    result.video_nodes_attributes = attributes;
    result.num_video_nodes = media.num_video_nodes;

} catch (e) {}
return result;
''';

SELECT
  client,
  SAFE_DIVIDE(COUNTIF(media_info.num_video_nodes > 0), COUNT(0)) AS pages_with_video_nodes_pct,
  SAFE_DIVIDE(COUNTIF('autoplay' IN UNNEST(media_info.video_nodes_attributes)), COUNTIF(media_info.num_video_nodes > 0)) AS pages_with_video_autoplay_pct,
  SAFE_DIVIDE(COUNTIF('muted' IN UNNEST(media_info.video_nodes_attributes)), COUNTIF(media_info.num_video_nodes > 0)) AS pages_with_video_muted_pct,
  SAFE_DIVIDE(COUNTIF(
    'autoplay' IN UNNEST(media_info.video_nodes_attributes) AND
    'muted' IN UNNEST(media_info.video_nodes_attributes)
  ), COUNTIF(media_info.num_video_nodes > 0
  )) AS pages_with_video_autoplay_muted_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    get_media_info(JSON_EXTRACT_SCALAR(payload, '$._media')) AS media_info
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
ORDER BY
  client
