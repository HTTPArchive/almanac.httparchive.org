#standardSQL
# images (and pages) with srcset w/wo sizes

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
  SAFE_DIVIDE(COUNTIF(media_info.num_srcset_all > 0), COUNT(0)) AS pages_with_srcset_pct,
  SAFE_DIVIDE(COUNTIF(media_info.num_srcset_sizes > 0), COUNT(0)) AS pages_with_srcset_sizes_pct,
  SAFE_DIVIDE((COUNTIF(media_info.num_srcset_all > 0) - COUNTIF(media_info.num_srcset_sizes > 0)), COUNT(0)) AS pages_with_srcset_wo_sizes_pct,
  SAFE_DIVIDE(SUM(media_info.num_srcset_sizes), SUM(media_info.num_srcset_all)) AS instances_of_srcset_sizes_pct,
  SAFE_DIVIDE((SUM(media_info.num_srcset_all) - SUM(media_info.num_srcset_sizes)), SUM(media_info.num_srcset_all)) AS instances_of_srcset_wo_sizes_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    get_media_info(JSON_EXTRACT_SCALAR(payload, '$._media')) AS media_info
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
ORDER BY
  client
