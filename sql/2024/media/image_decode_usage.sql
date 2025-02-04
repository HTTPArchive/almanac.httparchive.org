#standardSQL
# What percent of <img>s have decode=async?
# image_decode_usage.sql

CREATE TEMPORARY FUNCTION get_decode_info(images_string STRING)
RETURNS STRUCT<
  total INT64,
  decode_async INT64
> LANGUAGE js AS '''
let result = {};
try {
  let images = JSON.parse(images_string);
  if (!Array.isArray(images)) {
      return {};
  }

  result.total = images.length;
  result.decode_async = 0;

  for(let img of images) {
      if(img.decoding === 'async'){
          result.decode_async += 1
      }
  }
} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS pages_total,
  SAFE_DIVIDE(COUNTIF(images_info.total > 0), COUNT(0)) AS pages_with_img_pct,
  COUNTIF(images_info.decode_async > 0) AS pages_with_decode_async,
  SAFE_DIVIDE(COUNTIF(images_info.decode_async > 0), COUNT(0)) AS pages_with_decode_async_pct,
  SUM(images_info.total) AS img_total,
  SUM(images_info.decode_async) AS imgs_with_decode_async,
  SAFE_DIVIDE(SUM(images_info.decode_async), SUM(images_info.total)) AS imgs_with_decode_async_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    get_decode_info(JSON_EXTRACT_SCALAR(payload, '$._Images')) AS images_info
  FROM
    `httparchive.pages.2024_06_01_*`
)
GROUP BY
  client
ORDER BY
  client
