#standardSQL
# images with srcset descriptor_x descriptor_w

# returns all the data we need from _media
CREATE TEMPORARY FUNCTION get_media_info(media_string STRING)
RETURNS STRUCT<
  num_srcset_all INT64, 
  num_srcset_descriptor_x INT64,
  num_srcset_descriptor_w INT64
> LANGUAGE js AS '''
var result = {};
try {
    var media = JSON.parse(media_string);

    if (Array.isArray(media) || typeof media != 'object') return result;
	
    result.num_srcset_all = media.num_srcset_all;
    result.num_srcset_descriptor_x = media.num_srcset_descriptor_x;
	result.num_srcset_descriptor_w = media.num_srcset_descriptor_w;

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(media_info.num_srcset_all > 0) AS srcset_all,
  COUNTIF(media_info.num_srcset_descriptor_x > 0) AS srcset_descriptor_x,
  COUNTIF(media_info.num_srcset_descriptor_w > 0) AS srcset_descriptor_w
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
