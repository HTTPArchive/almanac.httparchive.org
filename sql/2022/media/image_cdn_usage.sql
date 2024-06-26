#standardSQL
# Looking for some obvious signs in the URL that the image is dynamically resized

CREATE TEMPORARY FUNCTION get_images(images_string STRING)
RETURNS ARRAY<STRUCT<url STRING>>
LANGUAGE js AS '''
var result = [];
try {
  var images = JSON.parse(images_string);
  for (const img of images){
    result.push({
      url: img.url
    })
  }
} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(DISTINCT pageUrl) AS pages,
  COUNT(0) AS images,
  SAFE_DIVIDE(COUNTIF(imgcdn1), COUNT(0)) AS img_with_cdn1_pct,
  SAFE_DIVIDE(COUNTIF(imgcdn2), COUNT(0)) AS img_with_cdn2_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    a.url AS pageUrl,
    imageurl.url,
    REGEXP_CONTAINS(imageurl.url, r'.*[,\/]w_\d+.*') AS imgcdn1,
    REGEXP_CONTAINS(imageurl.url, r'\?.*w=.*') AS imgcdn2
  FROM
    `httparchive.pages.2022_06_01_*` AS a,
    UNNEST(get_images(JSON_EXTRACT_SCALAR(payload, '$._Images'))) AS imageurl
)
GROUP BY
  client
