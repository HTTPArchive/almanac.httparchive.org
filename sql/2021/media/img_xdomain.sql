#standardSQL
# Cross domain image requests
CREATE TEMPORARY FUNCTION get_images(images_string STRING)
RETURNS ARRAY<STRUCT<url STRING>>
LANGUAGE js AS '''
var result = [];
try {
  var images = JSON.parse(images_string);
  for (img of images){
    result.push({
      url: img.url
    });
  }
} catch (e) {}
return result;
''';
SELECT
  client,
  COUNT(DISTINCT pageUrl) AS pages,
  count(0) AS images,
  SAFE_DIVIDE(COUNTIF(pageDomain = imageDomain), COUNT(0)) AS img_xdomain_pct,
  SAFE_DIVIDE(COUNTIF(pageDomain != imageDomain), COUNT(0)) AS img_samedomain_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    a.url AS pageUrl,
    FORMAT('%T', NET.REG_DOMAIN(a.url)) AS pageDomain,
    FORMAT('%T', NET.REG_DOMAIN(imageurl.url)) AS imageDomain
  FROM
    `httparchive.pages.2021_07_01_*` a,
    UNNEST(get_images(JSON_EXTRACT_SCALAR(payload, '$._Images'))) AS imageurl
)
GROUP BY
  client
