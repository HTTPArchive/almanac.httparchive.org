#standardSQL
# picture using min resolution
# picture_using_min_resolution.sql

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
  COUNTIF(media_info.num_picture_using_min_resolution > 0) AS picture_min_resolution_pages,
  COUNTIF(media_info.num_picture_img > 0) AS total_picture_pages,
  SAFE_DIVIDE(COUNTIF(media_info.num_picture_using_min_resolution > 0), COUNTIF(media_info.num_picture_img > 0)) AS pct_picture_min_resolution_pages,
  SUM(media_info.num_picture_using_min_resolution) AS picture_min_resolution_images,
  SUM(media_info.num_picture_img) AS total_picture_images,
  SAFE_DIVIDE(SUM(media_info.num_picture_using_min_resolution), SUM(media_info.num_picture_img)) AS pct_picture_min_resolution_images
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
