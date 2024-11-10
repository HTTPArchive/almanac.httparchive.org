#standardSQL
# How many picture elements are doing media and type switching?
# picture_switching.sql

CREATE TEMPORARY FUNCTION getPictureSwitching(payload STRING)
RETURNS ARRAY<STRUCT<pictureMediaSwitching BOOLEAN, pictureTypeSwitching BOOLEAN>>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var responsiveImages = JSON.parse($._responsive_images);
  responsiveImages = responsiveImages['responsive-images'];

  return responsiveImages.filter(img => img.isInPicture).map(({pictureMediaSwitching, pictureTypeSwitching}) => ({
    pictureMediaSwitching,
    pictureTypeSwitching
  }));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(image.pictureMediaSwitching) AS picture_media_switching,
  COUNTIF(image.pictureTypeSwitching) AS picture_type_switching,
  COUNT(0) AS total_picture,
  COUNTIF(image.pictureMediaSwitching) / COUNT(0) AS pct_picture_media_switching,
  COUNTIF(image.pictureTypeSwitching) / COUNT(0) AS pct_picture_type_switching
FROM
  `httparchive.pages.2024_06_01_*`,
  UNNEST(getPictureSwitching(payload)) AS image
GROUP BY
  client
