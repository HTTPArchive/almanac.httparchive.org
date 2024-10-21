#standardSQL
# <img>s whose sources have no dimensions (mostly not loaded because loading=lazy)
# image_0x0.sql

CREATE TEMPORARY FUNCTION getPixelInfo(responsiveImagesJsonString STRING)
RETURNS ARRAY<STRUCT<imgURL STRING, approximateResourceWidth INT64, approximateResourceHeight INT64, byteSize INT64, isPixel BOOL, isDataURL BOOL>>
LANGUAGE js AS '''
const parsed = JSON.parse(responsiveImagesJsonString);
if (parsed && parsed.map) {
  const dataRegEx = new RegExp('^data');
  return parsed.map(d => ({
    isPixel: d.approximateResourceWidth == 0 && d.approximateResourceHeight == 0,
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
    `httparchive.pages.2024_06_01_*`,
    UNNEST(getPixelInfo(JSON_QUERY(JSON_VALUE(payload, '$._responsive_images'), '$.responsive-images')))
),

counts AS (
  SELECT
    client,
    COUNT(0) AS total_imgs,
    COUNTIF(isPixel) AS zero_pixel_imgs,
    COUNTIF(isPixel AND isDataURL) AS zero_pixel_data_urls
  FROM
    imgs
  GROUP BY
    client
)

SELECT
  client,
  total_imgs,
  zero_pixel_imgs,
  zero_pixel_data_urls,
  SAFE_DIVIDE(zero_pixel_imgs, total_imgs) AS pct_zero_pixel_imgs,
  SAFE_DIVIDE(zero_pixel_data_urls, total_imgs) AS pct_zero_pixel_data_urls
FROM
  counts
