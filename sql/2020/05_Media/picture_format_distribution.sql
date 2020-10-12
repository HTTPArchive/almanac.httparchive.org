#standardSQL
# picture formats distribution

# returns all the data we need from _media
CREATE TEMPORARY FUNCTION get_media_info(media_string STRING)
RETURNS STRUCT<
  num_picture_img INT64,
  num_picture_formats INT64,
  picture_formats ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};
try {
    var media = JSON.parse(media_string);

    if (Array.isArray(media) || typeof media != 'object') return result;

    // fix "picture_formats":"[]"
    if (!Array.isArray(media.picture_formats))
    {
      media.picture_formats = JSON.parse(media.picture_formats);
    }

    // skip "picture_formats":[{}]
    if (media.picture_formats.length == 1 && Object.keys(media.picture_formats[0]).length === 0)
    {
      media.picture_formats = [];
    }

    result.picture_formats = media.picture_formats;
    result.num_picture_img = media.num_picture_img;
    result.num_picture_formats = result.picture_formats.length;

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(media_info.num_picture_img > 0) AS num_picture_img,
  COUNTIF(media_info.num_picture_formats > 0) AS num_picture_formats,
  COUNTIF(media_info.num_picture_formats = 1) AS num_picture_formats_1,
  COUNTIF(media_info.num_picture_formats = 2) AS num_picture_formats_2,
  COUNTIF(media_info.num_picture_formats = 3) AS num_picture_formats_3,
  COUNTIF(media_info.num_picture_formats >= 4) AS num_picture_formats_4
FROM
  (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    get_media_info(JSON_EXTRACT_SCALAR(payload, '$._media')) AS media_info
  FROM
    `httparchive.pages.2020_08_01_*`
  )
GROUP BY
  client;