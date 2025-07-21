#standardSQL
# percent of sites using images with srcset w/wo sizes, or picture element
CREATE TEMPORARY FUNCTION get_media_info(media_string STRING)
RETURNS STRUCT<
  num_srcset_all INT64,
  num_srcset_sizes INT64,
  num_picture_img INT64
> LANGUAGE js AS '''
var result = {
  num_srcset_all: 0,
  num_srcset_sizes: 0,
  num_picture_img: 0
};
try {
    var media = JSON.parse(media_string);
    if (Array.isArray(media) || typeof media != 'object') return result;
    result.num_srcset_all = media.num_srcset_all || 0;
    result.num_srcset_sizes = media.num_srcset_sizes || 0;
    result.num_picture_img = media.num_picture_img || 0;
} catch (e) {}
return result;
''';

WITH page_data AS (
  SELECT
    client,
    get_media_info(JSON_EXTRACT_SCALAR(payload, '$._media')) AS media_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01' AND is_root_page
)

SELECT
  client,
  ROUND(SAFE_DIVIDE(COUNTIF(media_info.num_srcset_all > 0), COUNT(0)) * 100, 2) AS pages_with_srcset_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(media_info.num_srcset_sizes > 0), COUNT(0)) * 100, 2) AS pages_with_srcset_sizes_pct,
  ROUND(SAFE_DIVIDE((COUNTIF(media_info.num_srcset_all > 0) - COUNTIF(media_info.num_srcset_sizes > 0)), COUNT(0)) * 100, 2) AS pages_with_srcset_wo_sizes_pct,
  ROUND(SAFE_DIVIDE(SUM(media_info.num_srcset_sizes), SUM(media_info.num_srcset_all)) * 100, 2) AS instances_of_srcset_sizes_pct,
  ROUND(SAFE_DIVIDE((SUM(media_info.num_srcset_all) - SUM(media_info.num_srcset_sizes)), SUM(media_info.num_srcset_all)) * 100, 2) AS instances_of_srcset_wo_sizes_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(media_info.num_picture_img > 0), COUNT(0)) * 100, 2) AS pages_with_picture_pct
FROM page_data
GROUP BY
  client
ORDER BY
  client 