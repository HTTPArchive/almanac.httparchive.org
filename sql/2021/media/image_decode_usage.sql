#standardSQL
# usage of alt text in images

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_decode_info(images_string STRING)
RETURNS STRUCT<
  total INT64,  
  decode_lazy INT64
> LANGUAGE js AS '''
var result = {};
try {
    var images = JSON.parse(images_string);

    if (Array.isArray(markup) || typeof markup != 'object') return result;
	
    result.total = images.length;
    result.decode_lazy = 0;

    for(let index in images){
        if(images[index].decoding==='lazy'){
            result.decode_lazy += 1
        }
    }
} catch (e) {}
return result;
''';

SELECT
  client,
  SAFE_DIVIDE(COUNTIF(images_info.total > 0), COUNT(0)) AS pages_with_img_pct,
  SAFE_DIVIDE(COUNTIF(images_info.decode_lazy > 0), COUNT(0)) AS pages_with_decode_lazy,
  SUM(images_info.total) AS img_total,
  SAFE_DIVIDE(SUM(images_info.decode_lazy), SUM(images_info.total)) AS decode_lazy_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    get_decode_info(JSON_EXTRACT_SCALAR(payload, '$._Images')) AS images_info
  FROM
    `httparchive.pages.2021_08_01_*`)
GROUP BY
  client
ORDER BY
  client
