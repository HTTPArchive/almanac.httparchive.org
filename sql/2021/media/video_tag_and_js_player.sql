#standardSQL
# get all pages with video nodes
# along with all pages with video js files
# check if video js is imported when a page has a video element or not

CREATE TEMPORARY FUNCTION get_media_info(media_string STRING)
RETURNS STRUCT<
  num_video_nodes INT64
> LANGUAGE js AS '''
var result = {};
try {
    var media = JSON.parse(media_string);

    if (Array.isArray(media) || typeof media != 'object') return result;

    result.num_video_nodes = media.num_video_nodes;

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNTIF(video_nodes) / COUNT(0) AS video_tag_pct,
  COUNTIF(player IS NOT NULL) / COUNT(0) AS js_video_player_pct,
  COUNTIF(video_nodes AND player IS NOT NULL) / COUNT(0) AS both_video_tag_js_player_pct
FROM (
  SELECT
    client,
    media_info.num_video_nodes > 0 AS video_nodes,
    player
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      get_media_info(JSON_EXTRACT_SCALAR(payload, '$._media')) AS media_info
    FROM
      `httparchive.pages.2021_08_01_*`
  )
  FULL OUTER JOIN (
    SELECT
      client,
      LOWER(REGEXP_EXTRACT(url, '(?i)(hls|video|shaka|jwplayer|brightcove-player-loader|flowplayer)[(?:\\.min)]?\\.js')) AS player
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-08-01' AND -- noqa: CV09
      type = 'script'
    GROUP BY
      client,
      page,
      player
  )
  USING (client, url)
  GROUP BY
    client,
    url,
    video_nodes,
    player
  HAVING
    video_nodes OR player IS NOT NULL
)
GROUP BY
  client
ORDER BY
  client
