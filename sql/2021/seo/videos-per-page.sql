#standardSQL
# Videos per page

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getVideosAlmanacInfo(almanac_string STRING)
RETURNS STRUCT<
  videos_total INT64
> LANGUAGE js AS '''
var result = {
  videos_total: 0
};
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    if (almanac.videos && almanac.videos.total) {
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
  APPROX_QUANTILES(almanac_info.videos_total, 1000)[OFFSET(percentile * 10)] AS videos_count

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    percentile,
    url,
    getVideosAlmanacInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS video_almanac_info
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST([10, 25, 50, 75, 90]) AS percentile
)
WHERE
  video_almanac_info.videos_total > 0
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
