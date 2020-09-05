#standardSQL
# percientile data from almanac per device

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_info(almanac_string STRING)
RETURNS STRUCT<
    videos_total INT64
> LANGUAGE js AS '''
var result = {};
try {
    var almanac;

    if (true) { // LIVE = true
      almanac = JSON.parse(almanac_string); // LIVE
    }
    else 
    {
      // TEST
      almanac = {
        "videos": {
          "total": Math.floor(Math.random() * 3)
        }
      };
    }

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    if (almanac.videos) {
      result.videos_total = almanac.videos.total;
    }

} catch (e) {}
return result;
''';

SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  # videos per page
  APPROX_QUANTILES(almanac_info.videos_total, 1000)[OFFSET(percentile * 10)] AS videos_count,

FROM (
  SELECT 
    _TABLE_SUFFIX AS client,
    percentile,
    url,
    #get_almanac_info('') AS almanac_info  # TEST
    get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info # LIVE
  FROM
  #`httparchive.sample_data.pages_*`, # TEST
  `httparchive.pages.2020_08_01_*`, # LIVE
  UNNEST([10, 25, 50, 75, 90]) AS percentile
)
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
