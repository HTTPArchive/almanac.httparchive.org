#standardSQL
# picture using orientation

# returns all the data we need from _media
CREATE TEMPORARY FUNCTION get_media_info(media_string STRING)
RETURNS STRUCT<
  num_picture_img INT64,
  num_picture_using_orientation INT64
> LANGUAGE js AS '''
var result = {};
try {
    var media = JSON.parse(media_string);

    if (Array.isArray(media) || typeof media != 'object') return result;

    result.num_picture_img = media.num_picture_img;
    result.num_picture_using_orientation = media.num_picture_using_orientation;

} catch (e) {}
return result;
''';

SELECT
  client,
  SAFE_DIVIDE(COUNTIF(media_info.num_picture_using_orientation > 0), COUNTIF(media_info.num_picture_img > 0)) AS pages_with_picture_orientation_pct,
  SAFE_DIVIDE(SUM(media_info.num_picture_using_orientation), SUM(media_info.num_picture_img)) AS occurences_of_picture_orientation_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    get_media_info(JSON_EXTRACT_SCALAR(payload, '$._media')) AS media_info
  FROM
    `httparchive.pages.2020_08_01_*`
)
GROUP BY
  client
ORDER BY
  client
