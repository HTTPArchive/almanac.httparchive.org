#standardSQL
# images with srcset w/wo sizes

# returns all the data we need from _media
CREATE TEMPORARY FUNCTION get_media_info(media_string STRING)
RETURNS STRUCT<
  num_srcset_all INT64, 
  num_srcset_sizes INT64
> LANGUAGE js AS '''
var result = {};
try {
    var media = JSON.parse(media_string);

    if (Array.isArray(media) || typeof media != 'object') return result;
	
    result.num_srcset_all = media.num_srcset_all;
    result.num_srcset_sizes = media.num_srcset_sizes;

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(media_info.num_srcset_all > 0) AS srcset_all,
  COUNTIF(media_info.num_srcset_sizes > 0) AS srcset_sizes,
  (COUNTIF(media_info.num_srcset_all > 0) - COUNTIF(media_info.num_srcset_sizes > 0)) AS srcset_wo_sizes
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
