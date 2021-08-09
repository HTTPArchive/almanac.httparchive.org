#standardSQL
# images srcset candidates average

# returns all the data we need from _media
CREATE TEMPORARY FUNCTION get_media_info(media_string STRING)
RETURNS STRUCT<
  num_srcset_all INT64,
  num_srcset_candidates_avg INT64
> LANGUAGE js AS '''
var result = {};
try {
    var media = JSON.parse(media_string);

    if (Array.isArray(media) || typeof media != 'object') return result;

    result.num_srcset_all = media.num_srcset_all;
    result.num_srcset_candidates_avg =
	    media.num_srcset_all == 0? 0: (media.num_srcset_candidates / media.num_srcset_all);

} catch (e) {}
return result;
''';

SELECT
  client,
  SAFE_DIVIDE(COUNTIF(media_info.num_srcset_all > 0), COUNT(0)) AS pages_with_srcset_pct,
  SAFE_DIVIDE(COUNTIF(media_info.num_srcset_candidates_avg >= 1 AND media_info.num_srcset_candidates_avg <= 3), COUNTIF(media_info.num_srcset_all > 0)) AS pages_with_srcset_candidates_1_3_pct,
  SAFE_DIVIDE(COUNTIF(media_info.num_srcset_candidates_avg >= 1 AND media_info.num_srcset_candidates_avg <= 5), COUNTIF(media_info.num_srcset_all > 0)) AS pages_with_srcset_candidates_1_5_pct,
  SAFE_DIVIDE(COUNTIF(media_info.num_srcset_candidates_avg > 5 AND media_info.num_srcset_candidates_avg <= 10), COUNTIF(media_info.num_srcset_all > 0)) AS pages_with_srcset_candidates_5_10_pct,
  SAFE_DIVIDE(COUNTIF(media_info.num_srcset_candidates_avg > 10 AND media_info.num_srcset_candidates_avg <= 15), COUNTIF(media_info.num_srcset_all > 0)) AS pages_with_srcset_candidates_10_15_pct,
  SAFE_DIVIDE(COUNTIF(media_info.num_srcset_candidates_avg > 15 AND media_info.num_srcset_candidates_avg <= 20), COUNTIF(media_info.num_srcset_all > 0)) AS pages_with_srcset_candidates_15_20_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    get_media_info(JSON_EXTRACT_SCALAR(payload, '$._media')) AS media_info
  FROM
    `httparchive.pages.2020_08_01_*`)
GROUP BY
  client
ORDER BY
  client
