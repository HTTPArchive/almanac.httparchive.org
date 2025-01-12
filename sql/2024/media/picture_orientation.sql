#standardSQL
# picture using orientation
# picture_orientation.sql

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
  COUNTIF(media_info.num_picture_using_orientation > 0) AS picture_orientation_pages,
  COUNTIF(media_info.num_picture_img > 0) AS total_picture_pages,
  SAFE_DIVIDE(COUNTIF(media_info.num_picture_using_orientation > 0), COUNTIF(media_info.num_picture_img > 0)) AS pct_picture_orientation_pages,
  SUM(media_info.num_picture_using_orientation) AS picture_orientation_images,
  SUM(media_info.num_picture_img) AS total_picture_images,
  SAFE_DIVIDE(SUM(media_info.num_picture_using_orientation), SUM(media_info.num_picture_img)) AS pct_picture_orientation_images
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    get_media_info(JSON_EXTRACT_SCALAR(payload, '$._media')) AS media_info
  FROM
    `httparchive.pages.2024_06_01_*`
)
GROUP BY
  client
ORDER BY
  client
