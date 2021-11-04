#standardSQL
# usage of alt text in images

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_images(images_string STRING)
RETURNS ARRAY<STRUCT<url STRING>>
LANGUAGE js AS '''
var result = [];
try {
    var images = JSON.parse(images_string);
    for(index in images){            
      result.push({ 
          url: images[index].url          
      })
    }         
} catch (e) {}
return result;
''';
SELECT
  client,
  COUNT(DISTINCT pageUrl) AS pages,
  count(0) AS images,
  SAFE_DIVIDE(COUNTIF(imgcdn1 = true), COUNT(0)) AS img_with_cdn1_pct,
  SAFE_DIVIDE(COUNTIF(imgcdn2 = true), COUNT(0)) AS img_with_cdn1_pct,
FROM (
  SELECT
  _TABLE_SUFFIX AS client,
    a.url as pageUrl,  
    imageurl.url,  
    REGEXP_CONTAINS(imageurl.url, r'.*[,\/]w_\d+.*') as imgcdn1,
    REGEXP_CONTAINS(imageurl.url, r'\?.*w=.*') as imgcdn2
  FROM
    `httparchive.pages.2021_07_01_*` a,
    UNNEST(get_images(JSON_EXTRACT_SCALAR(payload, '$._Images'))) AS imageurl    
    )
GROUP BY
  client