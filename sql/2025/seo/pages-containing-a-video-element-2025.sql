#standardSQL
# Pages containing a video element


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
  client,
  COUNT(0) AS total,

  # Pages with videos
  COUNTIF(videos_almanac_info.videos_total > 0) AS has_videos,
  SAFE_DIVIDE(COUNTIF(videos_almanac_info.videos_total > 0), COUNT(0)) AS pct_has_videos

FROM
  (
    SELECT
      client AS client,
      -- FIXED: Updated data source from payload to custom_metrics
    getVideosAlmanacInfo(
      TO_JSON_STRING(JSON_QUERY(TO_JSON(custom_metrics), '$.almanac'))
    ) AS videos_almanac_info
    FROM
      `httparchive.crawl.pages`
    WHERE
      date = '2025-06-01'
  )
GROUP BY
  client
