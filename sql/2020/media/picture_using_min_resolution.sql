#standardSQL
# picture using min resolution

# returns all the data we need from _media
CREATE TEMPORARY FUNCTION get_media_info(media_string STRING)
RETURNS STRUCT<
  num_picture_using_min_resolution INT64,
  num_picture_img INT64
> LANGUAGE js AS '''
var result = {};
try {
    var media = JSON.parse(media_string);

    if (Array.isArray(media) || typeof media != 'object') return result;

    result.num_picture_using_min_resolution = media.num_picture_using_min_resolution;
    result.num_picture_img = media.num_picture_img;

} catch (e) {}
return result;
''';

SELECT
  client,
  SAFE_DIVIDE(COUNTIF(media_info.num_picture_img > 0), COUNT(0)) AS pages_with_picture_pct,
  SAFE_DIVIDE(COUNTIF(media_info.num_picture_using_min_resolution > 0), COUNTIF(media_info.num_picture_img > 0)) AS pages_with_picture_min_resolution_pct,
  SAFE_DIVIDE(SUM(media_info.num_picture_using_min_resolution), SUM(media_info.num_picture_img)) AS occurences_of_picture_min_resolution_pct
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
