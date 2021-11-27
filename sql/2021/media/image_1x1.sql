CREATE TEMPORARY FUNCTION getPixelInfo(responsiveImagesJsonString STRING)
RETURNS ARRAY<STRUCT<imgURL STRING, approximateResourceWidth INT64, approximateResourceHeight INT64, byteSize INT64, isPixel BOOL, isDataURL BOOL>>
LANGUAGE js AS '''
const parsed = JSON.parse(responsiveImagesJsonString);
if (parsed && parsed.map) {
  const dataRegEx = new RegExp('^data');
  return parsed.map(d => ({
    isPixel: d.approximateResourceWidth == 1 && d.approximateResourceHeight == 1,
    isDataURL: dataRegEx.test(d.url)
  }));
}
''';

WITH imgs AS (
  SELECT
    _TABLE_SUFFIX AS client,
    isPixel,
    isDataURL
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getPixelInfo(JSON_QUERY(JSON_VALUE(payload, '$._responsive_images'), '$.responsive-images')))
),

counts AS (
  SELECT
    client,
    COUNT(0) AS total_imgs,
    COUNTIF(isPixel) AS one_pixel_imgs,
    COUNTIF(isPixel AND isDataURL) AS one_pixel_data_urls
  FROM
    imgs
  GROUP BY
    client
)

SELECT
  client,
  total_imgs,
  one_pixel_imgs,
  one_pixel_data_urls,
  SAFE_DIVIDE(one_pixel_imgs, total_imgs) AS pct_one_pixel_imgs,
  SAFE_DIVIDE(one_pixel_data_urls, total_imgs) AS pct_one_pixel_data_urls
FROM
  counts
